import 'dart:io';

import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final Cookie? ciSession;
  final bool isCiSessionUpdated;
  final String body;

  const ApiResponse(this.ciSession, this.isCiSessionUpdated, this.body);

  @override
  List<Object?> get props => [ciSession, body];
}
