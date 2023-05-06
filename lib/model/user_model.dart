import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String userId;
  final String profilePhoto;
  const UserModel({
    required this.name,
    required this.email,
    required this.userId,
    required this.profilePhoto,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? userId,
    String? profilePhoto,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'userId': userId,
      'profilePhoto': profilePhoto,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map["name"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      userId: (map["userId"] ?? '') as String,
      profilePhoto: (map["profilePhoto"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, userId: $userId, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.userId == userId &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        userId.hashCode ^
        profilePhoto.hashCode;
  }
}
