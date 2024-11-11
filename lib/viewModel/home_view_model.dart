// viewModels/home_view_model.dart
import 'package:flutter/material.dart';
import '../model/home.dart';

class HomeViewModel extends ChangeNotifier {
  // 스마트 추천 기능의 상태
  bool followAllOff = false;
  bool airConditionerOnlyOff = false;

  // 가전 제품 목록
  List<HomeDeviceModel> devices = [
    HomeDeviceModel(name: '건조기', iconPath: 'assets/images/dryer.png', isOn: true),
    HomeDeviceModel(name: '냉장고', iconPath: 'assets/images/ref.png', isOn: false),
    HomeDeviceModel(name: '에어컨', iconPath: 'assets/images/aircon.png', isOn: true),
    HomeDeviceModel(name: 'TV', iconPath: 'assets/images/tv.png', isOn: false),
  ];

  void addDevice(String scannedCode) {
    // 장치가 이미 추가되어 있는지 확인
    if (devices.any((device) => device.iconPath.contains(scannedCode))) {
      return; // 이미 추가된 경우, 아무 작업도 하지 않음
    }

    HomeDeviceModel? newDevice;
    if (scannedCode == 'dryer_code') {
      newDevice = HomeDeviceModel(name: '건조기', iconPath: 'assets/images/dryer.png', isOn: false);
    } else if (scannedCode == 'ref_code') {
      newDevice = HomeDeviceModel(name: '냉장고', iconPath: 'assets/images/ref.png', isOn: false);
    } else if (scannedCode == 'aircon_code') {
      newDevice = HomeDeviceModel(name: '에어컨', iconPath: 'assets/images/aircon.png', isOn: false);
    } else if (scannedCode == 'tv_code') {
      newDevice = HomeDeviceModel(name: 'TV', iconPath: 'assets/images/tv.png', isOn: false);
    } else if (scannedCode == 'robot_code') {
      newDevice = HomeDeviceModel(name: '로봇 청소기', iconPath: 'assets/images/robot.png', isOn: false);
    } else if (scannedCode == 'speaker_code') {
      newDevice = HomeDeviceModel(name: '스피커', iconPath: 'assets/images/speaker.png', isOn: false);
    }

    if (newDevice != null) {
      devices.add(newDevice);
      notifyListeners();
    }
  }


  // 스마트 추천 상태 변경
  void toggleFollowAllOff() {
    followAllOff = !followAllOff;
    notifyListeners();
  }

  void toggleAirConditionerOnlyOff() {
    airConditionerOnlyOff = !airConditionerOnlyOff;
    notifyListeners();
  }

  // 개별 기기 전원 상태 변경
  void toggleDevicePower(int index) {
    devices[index] = HomeDeviceModel(
      name: devices[index].name,
      iconPath: devices[index].iconPath,
      isOn: !devices[index].isOn,
    );
    notifyListeners();
  }
}
