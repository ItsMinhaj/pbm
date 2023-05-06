import 'dart:convert';

class UserModel {
  final String email;
  final String userId;
  final String profilePhoto;
  const UserModel({

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
       email: email ?? this.email,
      userId: userId ?? this.userId,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      'email': email,
      'userId': userId,
      'profilePhoto': profilePhoto,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(

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
    return 'UserModel( email: $email, userId: $userId, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return
        other.email == email &&
        other.userId == userId &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
    return
        email.hashCode ^
        userId.hashCode ^
        profilePhoto.hashCode;
  }
}
