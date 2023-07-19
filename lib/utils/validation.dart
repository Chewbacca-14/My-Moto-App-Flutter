//validate email
String? validateEmail(String? value) {
  RegExp regExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,4}$');
  if (value!.isEmpty) {
    return 'Please enter an email address.';
  } else if (!regExp.hasMatch(value)) {
    return 'Invalid email address.';
  } else {
    return null;
  }
}

//validate password
//min 8 max 15
//can`t use space
String? validatePassword(String? password) {
  if (password!.isEmpty) {
    return 'Please enter a password';
  } else if (password.length < 8 || password.length > 15) {
    return 'The password must have between 8 and 15 characters';
  } else if (password.contains(' ')) {
    return 'The password cannot contain spaces';
  } else {
    return null;
  }
}

//confirmPw validation
String? validateConfirmPassword(String? password) {
  if (password!.isEmpty) {
    return 'Please enter a password';
  } else {
    return null;
  }
}
