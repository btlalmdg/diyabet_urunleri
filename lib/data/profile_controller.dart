import 'package:flutter/foundation.dart';

class ProfileController extends ChangeNotifier {
  ProfileController._();
  static final ProfileController instance = ProfileController._();

  String? name;
  String? email;

  bool get isLoggedIn => email != null;

  void login({required String name, required String email}) {
    this.name = name;
    this.email = email;
    notifyListeners();
  }

  void logout() {
    name = null;
    email = null;
    notifyListeners();
  }
}
