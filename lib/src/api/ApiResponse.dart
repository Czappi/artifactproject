import 'dart:io';

import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final Cookie? ciSession;
  final String document;

  const ApiResponse(this.ciSession, this.document);

  @override
  List<Object?> get props => [ciSession, document];
}
