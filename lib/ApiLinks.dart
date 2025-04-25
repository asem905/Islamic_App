
// ignore_for_file: file_names

class Apilinks {
  static String baseUrl = "https://api.alquran.cloud/v1";
  static String quran = "$baseUrl/quran/quran-uthmani";
  static String quranInfo = "$baseUrl/surah";
  static String surahById = "$baseUrl/surah/100/en.asad -";
  static String hadithsBaseUrl = "https://hadithapi.com/api"; // Replace with actual Hadith API URL
  static String hadiths = "$hadithsBaseUrl/hadiths/?"; // Replace with actual Hadiths endpoint
}