import 'package:flutter/cupertino.dart';

class TogglePasswordProvider extends ChangeNotifier {
  bool password1 = true;
  bool password2 = true;
  bool password3 = true;
  bool password4 = true;
  bool password5 = true;

  togglePassword1() {
    password1 = !password1;
    notifyListeners();
  }

  togglePassword2() {
    password2 = !password2;
    notifyListeners();
  }

  togglePassword3() {
    password3 = !password3;
    notifyListeners();
  }

  togglePassword4() {
    password4 = !password4;
    notifyListeners();
  }

  togglePassword5() {
    password5 = !password5;
    notifyListeners();
  }
}
