part of 'prayertimes_cubit.dart';

sealed class PrayertimesState extends Equatable {
  const PrayertimesState();

  @override
  List<Object> get props => [];
}

final class PrayertimesInitial extends PrayertimesState {}

class PrayertimesLoaded extends PrayertimesState {
  final Map prayertimes;
  final String region;
  final String country;
  final Map date;
  final Map meta;
  const PrayertimesLoaded(this.prayertimes, this.region, this.country, this.date, this.meta);

  @override
  List<Object> get props => [prayertimes, region, country, date, meta, PrayertimesInitial];
}

class PrayertimesLoading extends PrayertimesState {}

class PrayertimesError extends PrayertimesState {
  final String message;
  const PrayertimesError(this.message);
}
