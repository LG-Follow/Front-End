// view/qr_scan_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../viewModel/home_view_model.dart';

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
    controller.scannedDataStream.listen((scanData) {
      if (!isScanned) { // 한 번만 스캔
        isScanned = true;
        final scannedCode = scanData.code; // 스캔된 코드

        // scannedCode가 null이 아닌 경우에만 addDevice 호출
        if (scannedCode != null) {
          final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
          homeViewModel.addDevice(scannedCode);

          // 알림 표시 후 홈 화면으로 이동
          controller.pauseCamera();
          _showScanCompletedDialog();
        }
      }
    });
  }


  void _showScanCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('스캔 완료'),
        content: Text('가전 제품이 추가되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 알림 닫기
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); // 홈 화면으로 이동
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
