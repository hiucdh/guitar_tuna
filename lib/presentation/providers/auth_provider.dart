import 'package:flutter/foundation.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/entities/user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUser loginUser;
  
  AuthProvider({required this.loginUser});

  bool _isLoading = false;
  User? _user;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  User? get user => _user;
  String? get error => _error;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await loginUser.execute(username, password);

    return result.fold(
      (failure) {
        _isLoading = false;
        _error = failure.message;
        notifyListeners();
        return false;
      },
      (user) {
        _isLoading = false;
        _user = user;
        _error = null;
        notifyListeners();
        return true;
      },
    );
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
