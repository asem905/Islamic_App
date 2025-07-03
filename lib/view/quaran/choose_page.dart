import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/view/quaran/explainations_page.dart';
import 'package:quaran_app/view/quaran/quaran_pageview.dart';
import 'package:quaran_app/view/quaran/viewall_surah.dart';

class QuranViewSelectionPage extends StatefulWidget {
  const QuranViewSelectionPage({Key? key}) : super(key: key);

  @override
  _QuranViewSelectionPageState createState() => _QuranViewSelectionPageState();
}

class _QuranViewSelectionPageState extends State<QuranViewSelectionPage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSurahHeader(),
            Expanded(
              child: _buildViewSelectionGrid(),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: _isDarkMode ? Colors.white : Colors.black87,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: _isDarkMode ? Colors.white : Colors.black87,
          ),
          onPressed: () {
            setState(() {
              _isDarkMode = !_isDarkMode;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSurahHeader() {
    return FadeInDown(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isDarkMode
                ? [AppColors.darkGradient[0], AppColors.darkGradient[1]]
                : [AppColors.lightGradient[0], AppColors.lightGradient[1]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _isDarkMode
                  ? Colors.black26
                  : const Color(0xFF056162).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "بسم الله الرحمن الرحيم",
              style: GoogleFonts.scheherazadeNew(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewSelectionGrid() {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: [
        _buildViewOption(
          icon: Icons.menu_book_rounded,
          title: 'Pages View',
          description: 'عرض سور القرآن الكريم في صفحات',
          color: Colors.orange,
          onTap: () {
            // Navigate to Pages View
            _navigateToView(ViewType.pages);
          },
        ),
        _buildViewOption(
          icon: Icons.hearing_rounded,
          title: 'Ayah by Ayah',
          description:
              'عرض سور القرآن الكريم كل آيه وحدها مع إمكانيه الاستماع لشيخ يقراء',
          color: Colors.purple,
          onTap: () {
            // Navigate to Ayah-by-Ayah View
            _navigateToView(ViewType.ayahByAyah);
          },
        ),
        _buildViewOption(
          icon: Icons.lightbulb_outline_rounded,
          title: 'Explanations',
          description: 'التفسير لكل آيه في سور القرآن الكريم',
          color: Colors.green,
          onTap: () {
            // Navigate to Explanations View
            _navigateToView(ViewType.explanations);
          },
        ),
      ].map((widget) => FadeInUp(child: widget)).toList(),
    );
  }

  Widget _buildViewOption({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _isDarkMode ? Colors.black26 : color.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: _isDarkMode ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToView(ViewType viewType) {
    // Implement navigation logic based on the selected view type
    switch (viewType) {
      case ViewType.pages:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranPageView(),
          ),
        );
        break;
      case ViewType.ayahByAyah:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewallSurahs(),
          ),
        );
        break;
      case ViewType.explanations:
        _showPageJumpDialog();
        break;
      case ViewType.combined:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CombinedView(
        //       surahNumber: widget.surahNumber,
        //       surahName: widget.surahName,
        //       ayahs: widget.ayahs,
        //     ),
        //   ),
        //);
        break;
    }
  }
  void _showPageJumpDialog() {
    final TextEditingController SurahName = TextEditingController();
    final TextEditingController ayahNumber = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ادخل رقم السورة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: SurahName,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'ادخل رقم السورة',
                ),
              ),
              TextField(
                controller: ayahNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'ادخل رقم الاية',
                ),
              ),
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
                if(SurahName.text.isNotEmpty && ayahNumber.text.isNotEmpty) {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExplanationPage(
                      title: SurahName.text,  
                      ayahNumber: ayahNumber.text,
                    ),
                  ),
                );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

// Enum for different view types
enum ViewType { pages, ayahByAyah, explanations, combined }
