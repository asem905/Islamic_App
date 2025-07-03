part of 'hadiths_cubit.dart';

sealed class HadithsState extends Equatable {
  const HadithsState();

  @override
  List<Object> get props => [];
}

final class HadithsLoading extends HadithsState {}
final class HadithsLoaded extends HadithsState {
  final List<HadithsModel> hadiths;
  const HadithsLoaded(this.hadiths);
}
final class HadithsLoadingError extends HadithsState {
  final String errorMessage;
  const HadithsLoadingError(this.errorMessage);
}