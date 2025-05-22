part of 'tafseer_cubit.dart';

sealed class TafseerState extends Equatable {
  const TafseerState();

  @override
  List<Object> get props => [];
}

final class TafseerInitial extends TafseerState {}
final class TafseerLoading extends TafseerState {}
final class TafseerLoaded extends TafseerState {
  final Map tafseerMap;
  const TafseerLoaded(this.tafseerMap);

  @override
  List<Object> get props => [tafseerMap];
}
final class TafseerError extends TafseerState {
  final String error;
  const TafseerError(this.error);

  @override
  List<Object> get props => [error];
}
