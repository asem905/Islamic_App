import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quaran_app/model/quaranmodel.dart';
import 'package:quaran_app/model/quaranpagesmodel.dart';
import 'package:quaran_app/model/quaransurahinfomodel.dart';
import 'package:quaran_app/model/surahmodel.dart';

sealed class QuaranState extends Equatable{
  const QuaranState();
  @override
  List<Object?> get props => [];
}
class QuaranLoading extends QuaranState{
    @override
    List<Object?> get props => [];
}
class QuaranModelSuccess extends QuaranState {
  final List<Surahs> surahs;
  const QuaranModelSuccess(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class QuaranSurahsInfoSuccess extends QuaranState {
  final List<QuaranSurahsInfo> surahsInfo;
  const QuaranSurahsInfoSuccess(this.surahsInfo);

  @override
  List<Object?> get props => [surahsInfo];
}
// ignore: must_be_immutable
class QuaranPagesloadedSuccess extends QuaranState{
  List<Pages> pages;
  QuaranPagesloadedSuccess(this.pages);
  @override
  List<Object?> get props => [pages];
}
class QuaranSurahloadingSuccess extends QuaranState {
  // ignore: non_constant_identifier_names
  final List<SurahModel> Ayahs;
  final String? name;
  final String? englishName;
  const QuaranSurahloadingSuccess(this.Ayahs, this.name, this.englishName);
  @override
  List<Object?> get props => [Ayahs];
}


class QuaranLoadingError extends QuaranState{
  final String errorMessage;
  const QuaranLoadingError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}