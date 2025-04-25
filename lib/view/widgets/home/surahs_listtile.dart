import 'package:flutter/material.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/view/surah_page.dart';

// ignore: camel_case_types
class hadithSurahListTile extends StatelessWidget {
  final String surahName;
  final int surahNumber;
  final String surahEnglishName;
  final String surahEnglishNameTranslation;
  final VoidCallback? onTap;
  final int? ayahsNumber;
  final String? surahType;
  final String? hadithStatus;
  final String? hadithTextArabic;
  final String? hadithTextEnglish;
  final String? hadithBookSlug;
  const hadithSurahListTile({
    super.key,
    this.onTap,
    required this.surahName,
    required this.surahNumber,
    required this.surahEnglishName,
    required this.surahEnglishNameTranslation,
    this.ayahsNumber,
    this.surahType,
    this.hadithStatus, this.hadithTextArabic, this.hadithTextEnglish, this.hadithBookSlug,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
          onTap: onTap ??
              () {
                //print("Surah Number===============================: ${state.surahsInfo[index].number}");
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SurahReadingPage(
                    surahNumber: surahNumber,
                    surahName: surahName,
                    surahEnglishName: surahEnglishName,
                  );
                }));
              },
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        surahNumber.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surahName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            surahEnglishName,
                            style: const TextStyle(color: AppColors.textDark),
                          ),
                          const SizedBox(height: 5),
                          ayahsNumber != null
                              ? Text(
                                  "$ayahsNumber Ayahs",
                                  style: const TextStyle(
                                      color: AppColors.textDark),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 5),
                          surahType != null
                              ? Text(
                                  surahType!,
                                  style: const TextStyle(
                                      color: AppColors.textDark),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  )))),
    );
  }
}
