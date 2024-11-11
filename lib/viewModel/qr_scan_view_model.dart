// viewModel/qr_scan_view_model.dart
import 'package:flutter/material.dart';
import '../model/device.dart';

class QRScanViewModel extends ChangeNotifier {
  Device? scannedDevice;

  // 더미 데이터로 ID에 해당하는 기기와 아이콘 설정
  final List<Device> devices = [
    Device(id: 'dummy_id', name: '세탁기', iconPath: 'assets/images/washing.png'),
    Device(id: 'dummy_id', name: '건조기', iconPath: 'assets/images/dryer.png'),
    Device(id: 'dummy_id', name: '냉장고', iconPath: 'assets/images/ref.png'),
    Device(id: 'dummy_id', name: 'TV', iconPath: 'assets/images/tv.png'),
    Device(id: 'dummy_id', name: '스피커', iconPath: 'assets/images/speaker.png'),
    Device(id: 'dummy_id', name: '로봇 청소기', iconPath: 'assets/images/robot.png'),

  ];

  // QR 코드 스캔 시 호출되는 메서드
  void onQRCodeScanned(String scannedId) {
    // 더미 데이터에서 ID와 일치하는 기기를 찾음
    scannedDevice = devices.firstWhere((device) => device.id == scannedId, orElse: () => devices[0]);
    notifyListeners();
  }
}
