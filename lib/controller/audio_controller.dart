import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

class QuranAudioController {
  final AudioPlayer _player = AudioPlayer();
  int? _currentAyahIndex;
  final List<int> surahAyahCounts = [
    7, 286, 200, 176, 120, 165, 206, 75, 129, 109, 123, 111, 43, 52, 99, 128, 
    111, 110, 98, 135, 112, 78, 118, 64, 77, 227, 93, 88, 69, 60, 34, 30, 73, 
    54, 45, 83, 182, 88, 75, 85, 54, 53, 89, 59, 37, 35, 38, 29, 18, 45, 60, 
    49, 62, 55, 78, 96, 29, 22, 24, 13, 14, 11, 11, 18, 12, 12, 30, 52, 52, 
    44, 28, 28, 20, 56, 40, 31, 50, 40, 46, 42, 29, 19, 36, 25, 22, 17, 19, 
    26, 30, 20, 15, 21, 11, 8, 8, 19, 5, 8, 8, 11, 11, 8, 3, 9, 5, 4, 7, 3, 
    6, 3, 5, 4, 5, 6
  ];
int getAbsoluteAyahNumber(int surahNumber, int ayahNumberInSurah) {
  if (surahNumber < 1 || surahNumber > 114) {
    throw ArgumentError('Surah number must be between 1 and 114');
  }
  if (ayahNumberInSurah < 1 || ayahNumberInSurah > surahAyahCounts[surahNumber - 1]) {
    throw ArgumentError('Ayah number is invalid for this surah');
  }

  // Sum ayahs from previous surahs
  int totalPreviousAyahs = 0;
  for (int i = 0; i < surahNumber - 1; i++) {
    totalPreviousAyahs += surahAyahCounts[i];
  }

  return totalPreviousAyahs + ayahNumberInSurah;
}

  // Array containing the number of ayahs in each surah (indexed from 0)
// For example, Surah Al-Fatiha (index 0) has 7 ayahs

  // Stream to broadcast current playing state
  Stream<QuranPlayerState> get playerStateStream =>
    Rx.combineLatest3<bool, ProcessingState, Duration, QuranPlayerState>(
      _player.playingStream,
      _player.processingStateStream,
      _player.positionStream,
      (playing, processingState, position) =>
        QuranPlayerState(
          playing: playing,
          processingState: processingState,
          position: position,
          ayahIndex: _currentAyahIndex,
        )
    );

  Future<void> init() async {
    // Set up audio session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    
    // Handle audio interruptions
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _player.stop();
      }
    });
  }
  
  // Helper method to generate URL for a specific ayah's audio
  String getAyahAudioUrl({
    required int ayahNumber,
    String quality = '128', // Options like '64', '128', etc.
    String reciter = 'ar.alafasy', // Default reciter
  }) {
    return 'https://cdn.islamic.network/quran/audio/$quality/$reciter/$ayahNumber.mp3';
  }

  // Helper method to generate URL for an entire surah's audio
  String getSurahAudioUrl({
    required int surahNumber,
    String quality = '128', // Options like '64', '128', etc.
    String reciter = 'ar.alafasy', // Default reciter
  }) {
    return 'https://cdn.islamic.network/quran/audio-surah/$quality/$reciter/$surahNumber.mp3';
  }
  
  // Play a specific ayah using the ayah number
  Future<void> playSpecificAyah({
  required int surahNumber,
  required int ayahNumber, // Ayah number in surah (1-based)
  required String reciter,
  required String quality,
}) async {
  final int absoluteAyahNumber = getAbsoluteAyahNumber(surahNumber, ayahNumber);
  final String audioUrl = getAyahAudioUrl(
    reciter: reciter,
    quality: quality,
    ayahNumber: absoluteAyahNumber,
  );
  await playAyah(audioUrl,absoluteAyahNumber);
}
  
  // Play an entire surah
  Future<void> playSurah({
    required int surahNumber,
    String quality = '128',
    String reciter = 'ar.alafasy',
  }) async {
    final audioUrl = getSurahAudioUrl(
      surahNumber: surahNumber,
      quality: quality,
      reciter: reciter,
    );
    
    await playAyah(audioUrl, surahNumber);
  }
  
  Future<void> playAyah(String audioUrl, int ayahIndex) async {
    // Check if the ayah is already playing and pause it
    if (_currentAyahIndex == ayahIndex && _player.playing) {
      await _player.pause();
      return;
    }
    
    _currentAyahIndex = ayahIndex;
    await _player.stop();
    
    try {
      await _player.setUrl(audioUrl);
      await _player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
  
  Future<void> pause() async {
    await _player.pause();
  }
  
  Future<void> stop() async {
    await _player.stop();
    _currentAyahIndex = null;
  }
  
  Future<void> dispose() async {
    await _player.dispose();
  }
}

class QuranPlayerState {
  final bool playing;
  final ProcessingState processingState;
  final Duration position;
  final int? ayahIndex;
  
  QuranPlayerState({
    required this.playing,
    required this.processingState,
    required this.position,
    this.ayahIndex,
  });
}