part of 'model.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String role;
  final Laundry? laundry;
  final bool? isAbsence;
  static String? token;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.laundry,
    this.isAbsence,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['name'],
        email: json['email'],
        role: json['roles'][0]['name'],
      );

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? role,
    Laundry? laundry,
    bool? isAbsence,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      laundry: laundry ?? this.laundry,
      isAbsence: isAbsence ?? this.isAbsence,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        role,
        laundry,
        isAbsence,
      ];
}
