class BrandModel {
  final String? name;
  final String? emoji;

  BrandModel({this.name, this.emoji});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'] as String?,
      emoji: json['emoji'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'emoji': emoji,
      };
}