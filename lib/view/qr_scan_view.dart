import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../viewModel/home_view_model.dart';
import '../viewModel/qr_scan_view_model.dart';

class QRScanView extends StatefulWidget {
  @override
  _QRScanViewState createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanned = false; // 중복 스캔 방지

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'QR 코드를 스캔하세요.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    // QR 스캔 스트림 처리
    controller.scannedDataStream.listen((scanData) {
      if (!isScanned) {
        isScanned = true;

        final scannedCode = 'speaker';

        // ViewModel에서 일치하는 기기 확인 및 추가
        _processScannedCode(scannedCode);
      }
    });
  }

  void _processScannedCode(String scannedCode) {
    // QRScanViewModel과 HomeViewModel 가져오기
    final qrScanViewModel = Provider.of<QRScanViewModel>(context, listen: false);
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    // ViewModel에서 스캔된 코드 처리
    qrScanViewModel.onQRCodeScanned(scannedCode);

    // ViewModel에서 일치하는 기기 가져오기
    final scannedDevice = qrScanViewModel.scannedDevice;

    if (scannedDevice != null) {
      // 홈 ViewModel에 기기 추가
      homeViewModel.addDevice(scannedDevice.id);

      // QR 카메라 일시 정지
      controller?.pauseCamera();

      // 완료 다이얼로그 표시
      _showScanCompletedDialog(scannedDevice.name);
    } else {
      // 일치하는 기기가 없을 경우
      _showErrorDialog();
    }
  }

  void _showScanCompletedDialog(String deviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('스캔 완료'),
        content: Text('$deviceName 추가되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); // 홈 화면으로 이동
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('오류'),
        content: Text('일치하는 기기를 찾을 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              Navigator.pop(context); // 이전 화면으로 이동
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

