import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quaran_app/ApiLinks.dart';
import 'package:quaran_app/model/prayertimes.dart';
import 'package:http/http.dart' as http;
part 'prayertimes_state.dart';

class PrayertimesCubit extends Cubit<PrayertimesState> {
  PrayertimesCubit() : super(PrayertimesLoading());

  void getPrayertimes() async{
    emit(PrayertimesLoading());
    try {
      var response = await http.get(Uri.parse(Apilinks.prayertimes));
      var data = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to load prayertimes');
      }
      print("data ${data['prayer_times']}=============================");
      emit(PrayertimesLoaded(data['prayer_times'],data['region'],data['country'],data['date'],data['meta'])); 
    } catch (e) {
      emit(PrayertimesError(e.toString()));
    }
  }
}
