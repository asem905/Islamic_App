import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quaran_app/ApiLinks.dart';
import 'package:quaran_app/model/hadiths_model.dart';
import 'package:http/http.dart' as http;
part 'hadiths_state.dart';

class HadithsCubit extends Cubit<HadithsState> {
  HadithsCubit() : super(HadithsLoading());
  final apiKey='\$2y\$10\$LtuPfwF5lw9Glsa6LHx7gKFLv6yfwD36P9LYiYLfaq45uxMUkyC';
  Future<void> fetchHadiths(int? page,String? book) async {
    emit(HadithsLoading());
    try {
      var response = book==null? await http.get(Uri.parse('${Apilinks.hadiths}apiKey=$apiKey&page=$page')) : await http.get(Uri.parse('${Apilinks.hadiths}apiKey=$apiKey&book=$book'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var data= json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to load hadiths');
      }
      emit(HadithsLoaded((data['hadiths']['data'] as List).map((e) => HadithsModel.fromJson(e)).toList()));
    } catch (e) {
      emit(HadithsLoadingError(e.toString()));
    }
  }
  
}
