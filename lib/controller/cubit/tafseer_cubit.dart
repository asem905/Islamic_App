import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'tafseer_state.dart';

class TafseerCubit extends Cubit<TafseerState> {
  TafseerCubit() : super(TafseerLoading());

  Future<void> getTafseer(int tafseerId, int surahNumber, int ayahNumber) async {
    try {
      emit(TafseerLoading());
      final response = await http.get(
        Uri.parse('http://api.quran-tafseer.com/tafseer/$tafseerId/$surahNumber/$ayahNumber'),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(utf8.decode(response.bodyBytes)); // <-- Key fix
        print(data); // Debug: Check if Arabic is correct
        emit(TafseerLoaded(data));
      } else {
        emit(TafseerError('Failed to load tafseer (${response.statusCode})'));
      }
    } catch (e) {
      emit(TafseerError('Error: ${e.toString()}'));
    }
  }
}