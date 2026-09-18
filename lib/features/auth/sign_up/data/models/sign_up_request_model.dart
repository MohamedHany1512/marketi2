class SignUpRequestModel {
  final String name;
  final String username; // للـ UI فقط
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpRequestModel({
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
     
      'phone': phone,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}