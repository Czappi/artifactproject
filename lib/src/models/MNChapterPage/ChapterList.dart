import 'package:equatable/equatable.dart';

class ChapterList extends Equatable {
  final String baseUrl;
  final List<String> indexes;

  const ChapterList(this.baseUrl, this.indexes);

  String linkByIndex(int index) => baseUrl + indexes[index];

  @override
  List<Object?> get props => [baseUrl, indexes];
}
