import 'package:flutter/material.dart';

import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/main.dart';
import 'package:quaran_app/view/hadiths/hadithpage.dart';
import 'package:quaran_app/view/quaran/quaran_pageview.dart';
import 'package:quaran_app/view/quaran/surah_page.dart';
import 'package:quaran_app/view/quaran/viewall_surah.dart';
import 'package:quaran_app/view/widgets/home/athkar/athkarhomepage.dart';

import 'package:quaran_app/view/widgets/home/gridfeatures.dart';
import 'package:quaran_app/view/widgets/home/lastreadcard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    HomePage(),
    const ViewallSurahs(),
    const Hadithpage(),
    const AthkarHomePage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    print("HomePage initialized");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        title: const Text(
          "Islamic App",
          style: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.bold,
          ),
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
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Features'),
                  const SizedBox(height: 15),

                  // Feature Grid Component
                  const FeatureGrid(),

                  // View all button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'اهلا بك فى تطبيق قرأنى متكامل',
              style: TextStyle(
                color: AppColors.textLight.withOpacity(0.8),
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'What would you like to explore today?',
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          LastReadCard(
            surahName:
                "اخر سوره قرأتها سوره ${sharedPreferences.getString("surahPageName")} صفحه ${sharedPreferences.getInt("page")}" ?? 'Not Yet Defined',
            onTap: () {
              String surahName = sharedPreferences.getString("surahName") ??
                  'سُورَةُ ٱلْفَاتِحَةِ';
              String surahEnglishName =
                  sharedPreferences.getString("surahEnglishName") ??
                      'Al-Faatiha';
              int surahNumber = sharedPreferences.getInt("surahNumber") ?? 0;
              print("surahNumber: $surahNumber, surahName: $surahName, surahEnglishName: $surahEnglishName");
              // Continue reading
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuranPageView(initialPage: sharedPreferences.getInt('page')??1,)));
            }, text: 'اخر صفحه قرأتها',
          ),
          const SizedBox(height: 20),
          // Last read component
          LastReadCard(
            ayahNumber: sharedPreferences.getInt("ayahNumber") ?? 1,
            surahName:
                sharedPreferences.getString("surahName") ?? 'Not Yet Defined',
            onTap: () {
              String surahName = sharedPreferences.getString("surahName") ??
                  'سُورَةُ ٱلْفَاتِحَةِ';
              String surahEnglishName =
                  sharedPreferences.getString("surahEnglishName") ??
                      'Al-Faatiha';
              int surahNumber = sharedPreferences.getInt("surahNumber") ?? 0;
              print("surahNumber: $surahNumber, surahName: $surahName, surahEnglishName: $surahEnglishName");
              // Continue reading
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SurahReadingPage(
                        surahNumber: surahNumber,
                        surahName: surahName,
                        surahEnglishName: surahEnglishName,
                      )));
            }, text: 'اخر ما استمعت له',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryDark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 35,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Islamic App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Explore the Divine Words',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.bookmark,
            title: 'Bookmarks',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.history,
            title: 'Reading History',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Quran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_edu),
          label: 'Hadith',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.av_timer_sharp),
          label: 'Azkar',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        print("index:============================== $index");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pages[index]));
      },
    );
  }
}
