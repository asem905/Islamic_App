import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/controller/cubit/quaran_cubit.dart';
import 'package:quaran_app/controller/cubit/quaran_state.dart';
import 'package:quaran_app/view/quaran/choose_page.dart';
import 'package:quaran_app/view/quaran/surah_page.dart';
import 'package:quaran_app/view/widgets/home/surahs_listtile.dart';

class ViewallSurahs extends StatefulWidget {
  const ViewallSurahs({super.key});

  @override
  State<ViewallSurahs> createState() => _ViewallSurahsState();
}

class _ViewallSurahsState extends State<ViewallSurahs> {
  @override
  @override
  void initState() {
    super.initState();

    // Force load data on initial page load
    context.read<QuaranCubit>().getSurahsData();

    // Set up a listener for when the page is focused again
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = Navigator.of(context);
      navigator.focusNode.enclosingScope!.addListener(() {
        if (navigator.focusNode.enclosingScope!.hasFocus) {
          // This page has focus again, reload data
          context.read<QuaranCubit>().getSurahsData();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          elevation: 0,
          title: const Text(
            "Al-Quran",
            style: TextStyle(
              color: AppColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const QuranViewSelectionPage()),
                  (_) => false);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.textLight),
              onPressed: () {
                // Search functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.textLight),
              onPressed: () {
                // Settings page
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(children: [
            BlocBuilder<QuaranCubit, QuaranState>(
              builder: (context, state) {
                if (state is QuaranLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is QuaranLoadingError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<QuaranCubit>().getSurahsData();
                        },
                        child: const Icon(Icons.refresh,
                            color: Colors.red, size: 50),
                      ),
                    ],
                  );
                } else if (state is QuaranSurahsInfoSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.surahsInfo.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            print(
                                "Surah Number===============================: ${state.surahsInfo[index].number}");
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (context) {
                              return SurahReadingPage(
                                surahNumber: state.surahsInfo[index].number!,
                                surahName: state.surahsInfo[index].name!,
                                surahEnglishName:
                                    state.surahsInfo[index].englishName!,
                              );
                            }));
                          },
                          child: hadithSurahListTile(
                            surahName: state.surahsInfo[index].name!,
                            surahNumber: state.surahsInfo[index].number!,
                            surahEnglishName:
                                state.surahsInfo[index].englishName!,
                            surahEnglishNameTranslation:
                                state.surahsInfo[index].englishNameTranslation!,
                            ayahsNumber: state.surahsInfo[index].numberOfAyahs,
                            surahType: state.surahsInfo[index].revelationType,
                          ));
                    },
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
          ]),
        ));
  }
}
