import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/controller/audio_controller.dart';
import 'package:quaran_app/controller/cubit/quaran_cubit.dart';
import 'package:quaran_app/controller/cubit/quaran_state.dart';
import 'package:quaran_app/main.dart';

class SurahReadingPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final String surahEnglishName; // Your ayahs data from API
  final bool modeCurrent;

  const SurahReadingPage({
    Key? key,
    this.modeCurrent = true,
    required this.surahNumber,
    required this.surahName,
    required this.surahEnglishName,
  }) : super(key: key);

  @override
  State<SurahReadingPage> createState() => _SurahReadingPageState();
}

class _SurahReadingPageState extends State<SurahReadingPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _textEditingController;
  final ScrollController _scrollController = ScrollController();
  double _fontSize = 24.0;
  bool _showTranslation = true;
  late bool _isNightMode;
  final List<dynamic> ayahs = []; // Replace with your API's ayahs data
  String newName = "";
  String newEnglishName = "";
  final QuranAudioController _audioController = QuranAudioController();
  // Array containing the number of ayahs in each surah (indexed from 0)
// For example, Surah Al-Fatiha (index 0) has 7 ayahs

// Function to calculate absolute ayah number
// Function to calculate absolute ayah number

  @override
  void initState() {
    // Initialize audio controller
    _audioController.init();
    _isNightMode = widget.modeCurrent;
    _textEditingController = TextEditingController();
    context.read<QuaranCubit>().getSurah(widget.surahNumber);
    super.initState();
  }

  @override
  void dispose() {
    // Make sure to dispose the audio controller
    _textEditingController.dispose();
    _audioController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isNightMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: _buildAppBar(),
      body: BlocBuilder<QuaranCubit, QuaranState>(
        builder: (context, state) {
          if (state is QuaranLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuaranSurahloadingSuccess) {
            ayahs.addAll(state.Ayahs);
            newName = state.name!;
            newEnglishName = state.englishName!;
            return Column(
              children: [
                _buildSurahHeader(),
                _buildControlBar(),
                Expanded(
                  child: _buildAyahsList(),
                ),
              ],
            );
          } else if (state is QuaranLoadingError) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(state.errorMessage,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 18))),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<QuaranCubit>().getSurah(widget.surahNumber);
                    },
                    child:
                        const Icon(Icons.refresh, size: 30, color: Colors.red),
                  ),
                ]);
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: _isNightMode ? Colors.white : AppColors.lightText,
        ),
        onPressed: () {
          if (widget.surahNumber > 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SurahReadingPage(
                        surahNumber: widget.surahNumber - 1,
                        surahName: widget.surahName,
                        surahEnglishName: widget.surahEnglishName,
                      )),
            );
          } else {
            Navigator.of(context).pushReplacementNamed('/surahsList');
          }
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.home,
            color: _isNightMode ? Colors.white : AppColors.lightText,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.share_rounded,
            color: _isNightMode ? Colors.white : AppColors.lightText,
          ),
          onPressed: () {
            // Add share functionality
          },
        ),
        IconButton(
          icon: Icon(
            _isNightMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: _isNightMode ? Colors.white : AppColors.lightText,
          ),
          onPressed: () {

            setState(() {
              _isNightMode = !_isNightMode;
              Navigator.of(context).pushReplacement( MaterialPageRoute(
                builder: (context) => SurahReadingPage(
                  surahNumber: widget.surahNumber,
                  surahName: widget.surahName,
                  surahEnglishName: widget.surahEnglishName,
                  modeCurrent: _isNightMode,
                )
              ));
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.bookmark_border_rounded,
            color: _isNightMode ? Colors.white : AppColors.lightText,size: 30,
          ),
          onPressed: () {
            sharedPreferences.setString("surahName", newName);
            sharedPreferences.setString("surahEnglishName", newEnglishName);
            sharedPreferences.setInt("surahNumber", widget.surahNumber);
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: Column(children: [
                const Text("تم حفظ السورة بنجاح",
                    style: TextStyle(color: Colors.green, fontSize: 18)),
                const Text("برجاء ادخال رقم الاية المراد حفظها",
                    style: TextStyle(color: Colors.green, fontSize: 18)),
                Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ayah number to save';
                        }
                      },
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ))
              ]),
              title: 'Successful saving operation',
              btnOkOnPress: () {
                sharedPreferences.setInt(
                    "ayahNumber", int.parse(_textEditingController.text));
              },
            ).show();
          },
        ),
      ],
    );
  }

  Widget _buildSurahHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isNightMode
              ? [AppColors.darkGradient[0], AppColors.darkGradient[1]]
              : [AppColors.lightGradient[0], AppColors.lightGradient[1]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: _isNightMode
                ? Colors.black26
                : AppColors.shadowLight.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Bismillah container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  _isNightMode ? Colors.black12 : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                style: GoogleFonts.amiri(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newEnglishName,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${ayahs.length} Verses',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              Text(
                newName,
                style: GoogleFonts.scheherazadeNew(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildControlBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: _isNightMode ? AppColors.darkCardBackground : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.text_fields,
                color: _isNightMode ? Colors.white70 : Colors.grey[700],
                size: 22,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 120,
                child: Slider(
                  value: _fontSize,
                  min: 18,
                  max: 36,
                  divisions: 6,
                  activeColor: AppColors.primarySurahColor,
                  inactiveColor:
                      _isNightMode ? Colors.white24 : Colors.grey[300],
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Switch(
                value: _showTranslation,
                activeColor: AppColors.primarySurahColor,
                onChanged: (value) {
                  setState(() {
                    _showTranslation = value;
                  });
                },
              ),
              Text(
                'Translation',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: _isNightMode ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildAyahsList() {
    return Container(
      color:
          _isNightMode ? AppColors.darkBackground : AppColors.lightBackground,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: ayahs.length,
        itemBuilder: (context, index) {
          // Access your ayah data here
          final ayah = ayahs[index];
          return _buildAyahItem(ayah, index);
        },
      ),
    );
  }

  _buildAyahItem(dynamic ayah, int index) {
    // Generate the audio URL using the helper methods in QuranAudioController
    int absoluteAyahNumber =
        _audioController.getAbsoluteAyahNumber(widget.surahNumber, index + 1);
    final audioUrl = _audioController.getAyahAudioUrl(
      reciter: 'ar.alafasy', // Default reciter - you can make this configurable
      quality: '128',
      ayahNumber:
          absoluteAyahNumber, // Default quality - you can make this configurable
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isNightMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Ayah number badge
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.shadowLight
                      .withOpacity(_isNightMode ? 0.7 : 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isNightMode ? Colors.white : AppColors.shadowLight,
                  ),
                ),
              ),
              const Spacer(),
              // Audio button with playing state indicator
              StreamBuilder<QuranPlayerState>(
                  stream: _audioController.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final isPlaying = playerState?.playing ?? false;
                    final isThisAyahPlaying =
                        playerState?.ayahIndex == index && isPlaying;

                    return IconButton(
                      icon: Icon(
                        isThisAyahPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_outline,
                        color: isThisAyahPlaying
                            ? AppColors.shadowLight
                            : (_isNightMode
                                ? Colors.white70
                                : AppColors.shadowLight),
                      ),
                      onPressed: () {
                        // Use the specific ayah playback method
                        _audioController.playSpecificAyah(
                          surahNumber: widget.surahNumber,
                          ayahNumber: index + 1,
                          reciter: 'ar.alafasy',
                          quality: '128',
                        );
                      },
                    );
                  }),
            ],
          ),

          const SizedBox(height: 16),

          // Arabic
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              // Replace with your API's ayah text field
              index == 0
                  ? ayahs[index].text.replaceFirst(
                      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ', ' ')
                  : ayahs[index].text,
              style: GoogleFonts.scheherazadeNew(
                fontSize: _fontSize,
                height: 1.6,
                color: _isNightMode ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),

          // Translation (conditionally displayed)
          if (_showTranslation) ...[
            const SizedBox(height: 16),
            Divider(
              color: _isNightMode ? Colors.white24 : Colors.grey[300],
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: _isNightMode ? AppColors.darkCardBackground : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<QuaranCubit, QuaranState>(
              builder: (context, state) {
                if (state is QuaranSurahloadingSuccess) {
                  return _buildNavigationButton(
                    icon: Icons.skip_previous,
                    label: 'Previous',
                    onPressed: () {
                      // Navigate to previous surah
                      if (widget.surahNumber > 1) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SurahReadingPage(
                            surahNumber: widget.surahNumber - 1,
                            surahName: state.name!,
                            surahEnglishName: state.englishName!,
                          ),
                        ));
                      }
                    },
                  );
                } else if (state is QuaranLoadingError) {
                  return _buildNavigationButton(
                    icon: Icons.skip_previous,
                    label: 'Previous',
                    onPressed: () {
                      // Handle error state
                    },
                  );
                }
                return const SizedBox(); // Placeholder for loading state
              },
            ),
            StreamBuilder<QuranPlayerState>(
                stream: _audioController.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final isPlaying = playerState?.playing ?? false;

                  return _buildNavigationButton(
                    icon: isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    label: isPlaying ? 'Pause' : 'Play All',
                    isMain: true,
                    onPressed: () {
                      if (isPlaying) {
                        _audioController.pause();
                      } else {
                        _playEntireSurah();
                      }
                    },
                  );
                }),
            BlocBuilder<QuaranCubit, QuaranState>(
              builder: (context, state) {
                if (state is QuaranSurahloadingSuccess) {
                  return _buildNavigationButton(
                    icon: Icons.skip_next,
                    label: 'Next',
                    onPressed: () {
                      // Navigate to next surah
                      if (widget.surahNumber < 114) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SurahReadingPage(
                            surahNumber: widget.surahNumber + 1,
                            surahName: state.name!,
                            surahEnglishName: state.englishName!,
                          ),
                        ));
                      }
                    },
                  );
                } else if (state is QuaranLoadingError) {
                  return _buildNavigationButton(
                    icon: Icons.skip_next,
                    label: 'Next',
                    onPressed: () {
                      // Handle error state
                    },
                  );
                }
                return const SizedBox(); // Placeholder for loading state
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required String label,
    bool isMain = false,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isMain ? 16 : 12),
            decoration: BoxDecoration(
              color: isMain
                  ? AppColors.shadowLight
                  : (_isNightMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey[100]),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isMain
                  ? Colors.white
                  : (_isNightMode ? Colors.white : AppColors.shadowLight),
              size: isMain ? 28 : 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: _isNightMode ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  void _playEntireSurah() async {
    // Play the entire surah using the surah audio URL
    await _audioController.playSurah(
      surahNumber: widget.surahNumber,
      reciter: 'ar.alafasy',
      quality: '128',
    );
  }
}
