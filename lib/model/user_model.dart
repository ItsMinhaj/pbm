import 'dart:convert';

class UserModel {
<<<<<<< HEAD
=======
  final String name;
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
  final String email;
  final String userId;
  final String profilePhoto;
  const UserModel({
<<<<<<< HEAD

=======
    required this.name,
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
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
<<<<<<< HEAD
       email: email ?? this.email,
=======
      name: name ?? this.name,
      email: email ?? this.email,
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
      userId: userId ?? this.userId,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
<<<<<<< HEAD

=======
      'name': name,
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
      'email': email,
      'userId': userId,
      'profilePhoto': profilePhoto,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
<<<<<<< HEAD

=======
      name: (map["name"] ?? '') as String,
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
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
<<<<<<< HEAD
    return 'UserModel( email: $email, userId: $userId, profilePhoto: $profilePhoto)';
=======
    return 'UserModel(name: $name, email: $email, userId: $userId, profilePhoto: $profilePhoto)';
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

<<<<<<< HEAD
    return
=======
    return other.name == name &&
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
        other.email == email &&
        other.userId == userId &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
<<<<<<< HEAD
    return
=======
    return name.hashCode ^
>>>>>>> 5f50e2439b2bb2dee19fa4bf5b2cc3a10248be31
        email.hashCode ^
        userId.hashCode ^
        profilePhoto.hashCode;
  }
}
