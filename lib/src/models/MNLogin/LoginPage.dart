import 'package:equatable/equatable.dart';

class LoginPage extends Equatable {
  final String captchaUrl, redirectUrl;

  const LoginPage(this.captchaUrl, this.redirectUrl);

  @override
  List<Object?> get props => [captchaUrl, redirectUrl];
}
