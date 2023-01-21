import 'package:application/model/requests/device_info.dart';


class LoginWithEmailRequest {
  String? email;
  String? password;
  DeviceInfo? deviceInfo;

  LoginWithEmailRequest({
    this.email,
    this.password,
    this.deviceInfo,
  });

  LoginWithEmailRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}
