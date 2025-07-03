import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/controller/cubit/quaran_cubit.dart';
import 'package:quaran_app/controller/cubit/quaran_state.dart';
import 'package:quaran_app/home.dart';
import 'package:quaran_app/main.dart';
import 'package:quaran_app/model/quaranmodel.dart';
import 'package:quaran_app/model/surahmodel.dart';

class QuranPageView extends StatefulWidget {
  final int initialPage;
  const QuranPageView({
    Key? key,
    this.initialPage = 1,
  }) : super(key: key);

  @override
  _QuranPageViewState createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  late PageController _pageController;
  int _currentPage = 1;
  String surahName = '';
  List<Map<String, int>> surahsAccordingToPage = [
    {'الفاتحة': 1},
    {'البقرة': 2},
    {'آل عمران': 50},
    {'النساء': 77},
    {'المائدة': 106},
    {'الأنعام': 128},
    {'الأعراف': 151},
    {'الأنفال': 177},
    {'التوبة': 187},
    {'يونس': 208},
    {'هود': 221},
    {'يوسف': 235},
    {'الرعد': 249},
    {'إبراهيم': 255},
    {'الحجر': 262},
    {'النحل': 267},
    {'الإسراء': 282},
    {'الكهف': 293},
    {'مريم': 305},
    {'طه': 312},
    {'الأنبياء': 322},
    {'الحج': 332},
    {'المؤمنون': 342},
    {'النور': 350},
    {'الفرقان': 359},
    {'الشعراء': 367},
    {'النمل': 377},
    {'القصص': 385},
    {'العنكبوت': 396},
    {'الروم': 404},
    {'لقمان': 411},
    {'السجدة': 415},
    {'الأحزاب': 418},
    {'سبأ': 428},
    {'فاطر': 434},
    {'يس': 440},
    {'الصافات': 446},
    {'ص': 453},
    {'الزمر': 458},
    {'غافر': 467},
    {'فصلت': 477},
    {'الشورى': 483},
    {'الزخرف': 489},
    {'الدخان': 496},
    {'الجاثية': 499},
    {'الأحقاف': 502},
    {'محمد': 507},
    {'الفتح': 511},
    {'الحجرات': 515},
    {'ق': 518},
    {'الذاريات': 520},
    {'الطور': 523},
    {'النجم': 526},
    {'القمر': 528},
    {'الرحمن': 531},
    {'الواقعة': 534},
    {'الحديد': 537},
    {'المجادلة': 542},
    {'الحشر': 545},
    {'الممتحنة': 549},
    {'الصف': 551},
    {'الجمعة': 553},
    {'المنافقون': 554},
    {'التغابن': 556},
    {'الطلاق': 558},
    {'التحريم': 560},
    {'الملك': 562},
    {'القلم': 564},
    {'الحاقة': 566},
    {'المعارج': 568},
    {'نوح': 570},
    {'الجن': 572},
    {'المزمل': 574},
    {'المدثر': 575},
    {'القيامة': 577},
    {'الإنسان': 578},
    {'المرسلات': 580},
    {'النبأ': 582},
    {'النازعات': 583},
    {'عبس': 585},
    {'التكوير': 586},
    {'الانفطار': 587},
    {'المطففين': 587},
    {'الانشقاق': 589},
    {'البروج': 590},
    {'الطارق': 591},
    {'الأعلى': 591},
    {'الغاشية': 592},
    {'الفجر': 593},
    {'البلد': 594},
    {'الشمس': 595},
    {'الليل': 595},
    {'الضحى': 596},
    {'الشرح': 596},
    {'التين': 597},
    {'العلق': 597},
    {'القدر': 598},
    {'البينة': 598},
    {'الزلزلة': 599},
    {'العاديات': 599},
    {'القارعة': 600},
    {'التكاثر': 600},
    {'العصر': 601},
    {'الهمزة': 601},
    {'الفيل': 601},
    {'قريش': 602},
    {'الماعون': 602},
    {'الكوثر': 602},
    {'الكافرون': 603},
    {'النصر': 603},
    {'المسد': 603},
    {'الإخلاص': 604},
    {'الفلق': 604},
    {'الناس': 604},
  ];
  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage - 1);
    // Ensure Quran data is loaded
    context.read<QuaranCubit>().getQuaranPages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String getSurahname(int pageNumber) {
    for (int i = 0; i < surahsAccordingToPage.length; i++) {
      if (pageNumber >= surahsAccordingToPage[i].values.first &&
          pageNumber <=
              (i < surahsAccordingToPage.length - 1
                  ? surahsAccordingToPage[i + 1].values.first - 1
                  : 604)) {
        {
          return surahsAccordingToPage[i].keys.first.toString();
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _pageController.jumpToPage(_currentPage - 1);
          },
          backgroundColor: Colors.blueGrey.withOpacity(0.6),
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showPageJumpDialog,
          ),
        ),
        body: Stack(
          children: [
            PageView.builder(
              reverse: true,
              controller: _pageController,
              itemCount: 604, // Total Quran pages
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index + 1;
                });
              },
              itemBuilder: (context, index) {
                return _buildQuranPage(index + 1);
              },
            ),
            Positioned(
              bottom: 10,
              right: size.width * 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    onPressed: () {
                      sharedPreferences.setInt('page', _currentPage);
                      surahName = getSurahname(_currentPage);
                      print(
                          "surahName: $surahName=============================================");
                      sharedPreferences.setString('surahPageName', surahName);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم الحفظ بنجاح'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      size: 30,
                      color: Colors.black,
                    )),
              ),
            ),
          ],
        ));
  }

  Widget _buildQuranPage(int pageNumber) {
    return Container(
      color: Colors.white,
      child: _buildPageContent(pageNumber),
    );
  }

  Widget _buildPageContent(int pageNumber) {
    return BlocBuilder<QuaranCubit, QuaranState>(
      builder: (context, state) {
        if (state is QuaranLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuaranPagesloadedSuccess) {
          // Get the Surah name for the current page

          final pageRequired = state.pages
              .where((page) => page.pageNumber == pageNumber)
              .toList();
          return Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              pageRequired.isEmpty ? '' : pageRequired[0].pageUrl!,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child:
                        Icon(Icons.error_outline, size: 40, color: Colors.grey),
                  ),
                );
              },
              fit: BoxFit.fill,
            ),
          ));
        } else if (state is QuaranLoadingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.errorMessage}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<QuaranCubit>().getQuotes(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No data available'),
                SizedBox(height: 16),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }

  void _showPageJumpDialog() {
    final TextEditingController pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Jump to Page'),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter page number (1-604)',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Go'),
              onPressed: () {
                int? page = int.tryParse(pageController.text);
                if (page != null && page >= 1 && page <= 604) {
                  _pageController.jumpToPage(page - 1);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
