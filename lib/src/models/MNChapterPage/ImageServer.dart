import 'package:equatable/equatable.dart';

class ImageServer extends Equatable {
  final String name;
  final String? url;

  const ImageServer(this.name, {this.url});

  @override
  List<Object?> get props => [name, url];
}
