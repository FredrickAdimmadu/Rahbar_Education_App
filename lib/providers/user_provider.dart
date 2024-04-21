import 'package:flutter/widgets.dart';
import 'package:rahbar/models/rahbar_user.dart';
import 'package:rahbar/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  RahbarUser? _user;
  final AuthMethods _authMethods = AuthMethods();



  RahbarUser get getUser => _user ?? RahbarUser(
    image: '',
    about: '',
    name: '',
    createdAt: '',
    isOnline: false,
    id: '',
    lastActive: '',
    email: '',
    pushToken: '',
    number: '',
    relationship: '',
    country: '',
    gender: '',
    language: '',

    deviceModel: '',
    deviceVersion: '',
    deviceLocation: '',
    ipAddress: '',
    currentDateTime: '',
    password: '',

  );

  Future<void> refreshUser() async {
    RahbarUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
