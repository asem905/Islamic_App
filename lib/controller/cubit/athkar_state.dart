part of 'athkar_cubit.dart';

sealed class AthkarState extends Equatable {
  const AthkarState();

  @override
  List<Object> get props => [];
}

final class AthkarLoading extends AthkarState {}

final class AthkarMorningLoaded extends AthkarState {
  final List<MorningAzkar> athkarMorningList;
  const AthkarMorningLoaded(this.athkarMorningList);
  @override
  List<Object> get props => [athkarMorningList];
}

final class AthkarEveningLoaded extends AthkarState {
  final List<EveningAzkar> athkarEveningList;
  const AthkarEveningLoaded(this.athkarEveningList);
  @override
  List<Object> get props => [athkarEveningList];
}

final class AthkarSleepLoaded extends AthkarState {
  final List<SleepAzkar> athkarSleepList;
  const AthkarSleepLoaded(this.athkarSleepList);
  @override
  List<Object> get props => [athkarSleepList];
}
final class AthkarPrayerLoaded extends AthkarState {
  final List<PrayerAzkar> athkarPrayerList;
  const AthkarPrayerLoaded(this.athkarPrayerList);
  @override
  List<Object> get props => [athkarPrayerList];
}

final class AthkarPrayerLaterLoaded extends AthkarState {
  final List<PrayerLaterAzkar> athkarPrayerLaterList;
  const AthkarPrayerLaterLoaded(this.athkarPrayerLaterList);
  @override
  List<Object> get props => [athkarPrayerLaterList];
}                               
final class AthkarWuduLoaded extends AthkarState {
  final List<WuduAzkar> athkarWuduList;
  const AthkarWuduLoaded(this.athkarWuduList);
  @override
  List<Object> get props => [athkarWuduList];
}
final class AthkarHomeLoaded extends AthkarState {
  final List<HomeAzkar> athkarHomeList;
  const AthkarHomeLoaded(this.athkarHomeList);
  @override
  List<Object> get props => [athkarHomeList];
}
final class AthkarWakeUpLoaded extends AthkarState {
  final List<WakeUpAzkar> athkarWakeUpList;
  const AthkarWakeUpLoaded(this.athkarWakeUpList);
  @override
  List<Object> get props => [athkarWakeUpList];
}
final class AthkarMiscellaneousLoaded extends AthkarState {
  final List<MiscellaneousAzkar> athkarMiscellaneousList;
  const AthkarMiscellaneousLoaded(this.athkarMiscellaneousList);
  @override
  List<Object> get props => [athkarMiscellaneousList];
}
final class AthkarMosqueLoaded extends AthkarState {
  final List<MosqueAzkar> athkarMosqueList;
  const AthkarMosqueLoaded(this.athkarMosqueList);
  @override
  List<Object> get props => [athkarMosqueList];
}
final class AthkarKhalaLoaded extends AthkarState {
  final List<KhalaAzkar> athkarKhalaList;
  const AthkarKhalaLoaded(this.athkarKhalaList);
  @override
  List<Object> get props => [athkarKhalaList];
}
final class AthkarFoodLoaded extends AthkarState {
  final List<FoodAzkar> athkarFoodList;
  const AthkarFoodLoaded(this.athkarFoodList);
  @override
  List<Object> get props => [athkarFoodList];
}
final class AthkarHajjAndUmrahLoaded extends AthkarState {
  final List<HajjAndUmrahAzkar> athkarHajjAndUmrahList;
  const AthkarHajjAndUmrahLoaded(this.athkarHajjAndUmrahList);
  @override
  List<Object> get props => [athkarHajjAndUmrahList];
}
final class AthkarAdhanLoaded extends AthkarState {
  final List<AdhanAzkar> athkarAdhanList;
  const AthkarAdhanLoaded(this.athkarAdhanList);
  @override
  List<Object> get props => [athkarAdhanList];
}


final class AthkarError extends AthkarState {
  final String errorMessage;
  const AthkarError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
