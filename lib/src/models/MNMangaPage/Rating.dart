import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final double average;
  final double? best;
  final int? votes;

  const Rating(this.average, this.best, this.votes);

  @override
  List<Object?> get props => [average, best, votes];
}
