class ProfileModel {
  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? image;

  ProfileModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['message'] ?? json;
    return ProfileModel(
      id: data['_id'],
      name: data['name'],
      phone: data['phone'],
      email: data['email'],
      address: data['address'],
      image: data['image'],
    );
  }
}