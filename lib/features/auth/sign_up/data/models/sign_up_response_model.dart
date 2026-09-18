class SignUpResponseModel {
  final String message;

  const SignUpResponseModel({
    required this.message,
  });

  factory SignUpResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SignUpResponseModel(
      message: json['message'] ,
    );
  }
}