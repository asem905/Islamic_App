import 'dart:convert';
import 'dart:io';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/ApiLinks.dart';

import 'package:http/http.dart' as http;
import 'package:quaran_app/controller/cubit/quaran_state.dart';
import 'package:quaran_app/model/quaranmodel.dart';
import 'package:quaran_app/model/quaranpagesmodel.dart';
import 'package:quaran_app/model/quaransurahinfomodel.dart';
import 'package:quaran_app/model/surahmodel.dart';

class QuaranCubit extends Cubit<QuaranState> {
  QuaranCubit() : super(QuaranLoading()); // Start with initial state

  QuaranModel? quaranModel;
  QuaranSurahsInfo? quaranSurahsInfo;
  SurahModel? surahModel;

  Future<void> getQuotes() async {
    try {
      emit(QuaranLoading());

      final response = await http.get(Uri.parse(Apilinks.quran));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(
            "response.body:hi ${data['data']['surahs']}==================================");
        emit(QuaranModelSuccess(
          (data['data']['surahs'] as List)
              .map((e) => Surahs.fromJson(e))
              .toList(),
        ));
      } else {
        emit(const QuaranLoadingError('Failed to load quotes'));
      }
    } catch (e) {
      emit(const QuaranLoadingError('An error occurred'));
    }
  }

  Future<void> getSurahsData() async {
    emit(QuaranLoading());
    try {
      final response = await http.get(Uri.parse(Apilinks.quranInfo));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        emit(QuaranSurahsInfoSuccess(
          (data['data'] as List)
              .map((e) => QuaranSurahsInfo.fromJson(e))
              .toList(),
        ));
      } else {
        emit(const QuaranLoadingError('Failed to load data'));
      }
    } catch (e) {
      if (e is FormatException) {
        emit(QuaranLoadingError('JSON parsing error: ${e.message}'));
      } else if (e is SocketException) {
        emit(const QuaranLoadingError(
            'Network error: Please check your connection'));
      } else {
        emit(QuaranLoadingError(
            'An error occurred: check your connection for $e'));
      }
    }
  }

  Future<void> getSurah(int id) async {
    emit(QuaranLoading());
    try {
      final response =
          await http.get(Uri.parse('${Apilinks.baseUrl}/surah/$id/en.asad -'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        emit(QuaranSurahloadingSuccess(
          (data['data']['ayahs'] as List)
              .map((e) => SurahModel.fromJson(e))
              .toList(),
          data['data']['name'],
          data['data']['englishName'],
        ));
      } else {
        emit(const QuaranLoadingError('Failed to load data for this surah'));
      }
    } catch (e) {
      emit(QuaranLoadingError(
          'An error occurred: check your connection for $e'));
    }
  }

  Future<void> getAyahAudio(String id) async {
    emit(QuaranLoading());
    try {
      final response =
          await http.get(Uri.parse('${Apilinks.baseUrl}/quran/audio/$id'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        emit(QuaranSurahloadingSuccess(
          (data['data']['ayahs'] as List)
              .map((e) => SurahModel.fromJson(e))
              .toList(),
          data['data']['name'],
          data['data']['englishName'],
        ));
      } else {
        emit(const QuaranLoadingError('Failed to load data'));
      }
    } catch (e) {
      emit(QuaranLoadingError(
          'An error occurred: check your connection for $e'));
    }
  }

  Future<void> getQuaranPages() async {
    emit(QuaranLoading());
    try {
      final response = await http.get(Uri.parse(Apilinks.quaranPages));
      if (response.statusCode == 200) {
        print("${response.body}============================================");
        var data = json.decode(response.body);
        print(data);
        emit(QuaranPagesloadedSuccess(
            (data['pages'] as List).map((e) => Pages.fromJson(e)).toList(),));
      } else {
        emit(const QuaranLoadingError('Failed to load data'));
      }
    } catch (e) {
      emit(QuaranLoadingError(
          'An error occurred: check your connection for $e'));
    }
  }
}
