import 'package:flutter/foundation.dart';

import '../models/user_account.dart';

class AuthProvider extends ChangeNotifier {
  UserAccount? _currentUser;

  UserAccount? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void enter(String name) {
    _currentUser = UserAccount(
      name: name.trim().replaceAll(RegExp(r'\s+'), ' '),
    );
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
