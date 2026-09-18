String? Function(String?) required(String message) {
    return (value) {
      return value == null || value.trim().isEmpty ? message : null;
    };
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email';
    }
  
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(value.trim())
        ? null
        : 'Please enter a valid email';
  }


  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return value.length < 8 ? 'Password must be at least 8 characters' : null;
  }
 String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    return null;}
  String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    return null;}
  String? userValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter username';
    }
    return null;}
   

