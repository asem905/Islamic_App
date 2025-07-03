import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  QiblaCubit() : super(QiblaLoading());

  void getQibla(double latitude, double longitude) async{
    emit(QiblaLoading());
    try{
      var response=await http.get(Uri.parse("https://api.aladhan.com/v1/qibla/$latitude/$longitude"));
      print(response.body+"===================================");
      if(response.statusCode==200){
        var data=json.decode(response.body);
        emit(QiblaLoaded(qiblaDirection: data["data"]["direction"]));
      }else {
        emit(const QiblaError(message: 'Failed to load data'));
      }
    }catch(e){
      emit(QiblaError(message: 'An error occurred check your connection for $e'));
    }
  }
}
