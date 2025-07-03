part of 'qibla_cubit.dart';

sealed class QiblaState extends Equatable {
  const QiblaState();

  @override
  List<Object> get props => [];
}

final class QiblaLoading extends QiblaState {}
final class QiblaLoaded extends QiblaState {
  final double qiblaDirection;

  const QiblaLoaded({required this.qiblaDirection});

  @override
  List<Object> get props => [qiblaDirection];
  
}
final class QiblaError extends QiblaState {
  final String message;

  const QiblaError({required this.message});

  @override
  List<Object> get props => [message];
}