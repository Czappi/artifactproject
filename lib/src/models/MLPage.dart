import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:equatable/equatable.dart';

class MLPage extends Equatable {
  final List<MLElement> mlElements;
  final int lastPage;

  const MLPage(this.mlElements, this.lastPage);

  @override
  List<Object?> get props => [];
}
