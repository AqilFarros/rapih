part of 'model.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String role;
  static String? token;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['name'],
        email: json['email'],
        role: json['roles'][0]['name'],
      );

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        role,
      ];
}
