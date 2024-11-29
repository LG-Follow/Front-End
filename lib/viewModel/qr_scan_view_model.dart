// QR 스캔 결과와 일치하는 기기를 찾는 기능
import 'package:flutter/material.dart';
import '../model/device.dart';

class QRScanViewModel extends ChangeNotifier {
  Device? scannedDevice;

  // ID에 해당하는 기기와 아이콘 설정
  final List<Device> devices = [
    Device(id: 'washer', name: '세탁기', iconPath: 'assets/images/washing.png'),
    Device(id: 'dryer', name: '건조기', iconPath: 'assets/images/dryer.png'),
    Device(id: 'fridge', name: '냉장고', iconPath: 'assets/images/ref.png'),
    Device(id: 'tv', name: 'TV', iconPath: 'assets/images/tv.png'),
    Device(id: 'speaker', name: '스피커', iconPath: 'assets/images/speaker.png'),
    Device(id: 'robot', name: '로봇 청소기', iconPath: 'assets/images/robot.png'),

  ];

  // QR 코드 스캔 시 호출되는 메서드
  void onQRCodeScanned(String scannedId) {
    // ID와 일치하는 기기를 찾음
    scannedDevice = devices.firstWhere((device) => device.id == scannedId, orElse: () => devices[0]);
    notifyListeners();
  }
}
