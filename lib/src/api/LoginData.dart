import 'package:equatable/equatable.dart';
import 'dart:convert';

class LoginData extends Equatable {
  final String encryptedId, encryptedUsername;

  const LoginData(this.encryptedId, this.encryptedUsername);

  String get username => base64.decode(encryptedUsername).toString();

  String get id => base64.decode(encryptedId).toString();

  @override
  List<Object?> get props => [encryptedId, encryptedUsername];
}
