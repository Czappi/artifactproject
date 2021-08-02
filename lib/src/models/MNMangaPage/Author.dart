import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String name;
  final String? href;

  const Author(this.name, this.href);

  @override
  List<Object?> get props => [name, href];
}
