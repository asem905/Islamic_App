import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quaran_app/model/athkarmodel.dart';
import 'package:http/http.dart' as http;
part 'athkar_state.dart';
class AthkarCubit extends Cubit<AthkarState> {
  AthkarCubit() : super(AthkarLoading());

  void getAthkar(String athkarName) async {
    emit(AthkarLoading());
    try {
      var response = await http.get(Uri.parse("https://alquran.vip/APIs/azkar"));
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }
      var data = json.decode(response.body);
      print(data);
      if(athkarName.isNotEmpty){
        if(athkarName=='morningazkar'){
          print("morningazkar================================================");
          emit(AthkarMorningLoaded((data['morning_azkar'] as List).map((e) => MorningAzkar.fromJson(e)).toList()));
        }else if(athkarName=='eveningazkar'){
          emit(AthkarEveningLoaded((data['evening_azkar'] as List).map((e) => EveningAzkar.fromJson(e)).toList()));
        }else if(athkarName=='prayerazkar'){
          emit(AthkarPrayerLoaded((data['prayer_azkar'] as List).map((e) => PrayerAzkar.fromJson(e)).toList()));
        }else if(athkarName=='prayerLaterazkar'){
          emit(AthkarPrayerLaterLoaded((data['prayer_later_azkar'] as List).map((e) => PrayerLaterAzkar.fromJson(e)).toList()));
        }else if(athkarName=='sleepazkar'){
          emit(AthkarSleepLoaded((data['sleep_azkar'] as List).map((e) => SleepAzkar.fromJson(e)).toList()));
        }else if(athkarName=='wakeupazkar'){
          emit(AthkarWakeUpLoaded((data['wake_up_azkar'] as List).map((e) => WakeUpAzkar.fromJson(e)).toList()));
        }else if(athkarName=='mosqueazkar'){
          emit(AthkarMosqueLoaded((data['mosque_azkar'] as List).map((e) => MosqueAzkar.fromJson(e)).toList()));
        }else if(athkarName=='miscellaneousazkar'){
          emit(AthkarMiscellaneousLoaded((data['miscellaneous_azkar'] as List).map((e) => MiscellaneousAzkar.fromJson(e)).toList()));
        }else if(athkarName=='adhanazkar'){
          print("Hi from here===============================");
          print(data["adhan_azkar"]);
          emit(AthkarAdhanLoaded((data["adhan_azkar"] as List).map((e) => AdhanAzkar.fromJson(e)).toList()));
        }else if(athkarName=='wuduazkar'){
          
          emit(AthkarWuduLoaded((data['wudu_azkar'] as List).map((e) => WuduAzkar.fromJson(e)).toList()));
        }else if(athkarName=='homeazkar'){
          emit(AthkarHomeLoaded((data['home_azkar'] as List).map((e) => HomeAzkar.fromJson(e)).toList()));
        }else if(athkarName=='khalaazkar'){
          emit(AthkarKhalaLoaded((data['khala_azkar'] as List).map((e) => KhalaAzkar.fromJson(e)).toList()));
        }else if(athkarName=='foodazkar'){
          emit(AthkarFoodLoaded((data['food_azkar'] as List).map((e) => FoodAzkar.fromJson(e)).toList()));
        }else if(athkarName=='hajjandumrahazkar'){
          emit(AthkarHajjAndUmrahLoaded((data['hajj_and_umrah_azkar'] as List).map((e) => HajjAndUmrahAzkar.fromJson(e)).toList()));
        }else {
          // emit(AthkarMorningLoaded((data['morning_azkar'] as List).map((e) => .fromJson(e)).toList()));
          emit(AthkarError("no data found"));
        }
      }
    } catch (e) {
      emit(AthkarError(e.toString()));
    }
  }
}
