import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final String title, url;

  const Chapter(this.title, this.url);

  @override
  List<Object?> get props => [title, url];
}
