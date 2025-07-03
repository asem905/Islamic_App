import 'package:flutter/material.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/view/azkar/athkarpage.dart';
import 'package:quaran_app/view/quaran/choose_page.dart';
import 'package:quaran_app/view/hadiths/hadithpage.dart';
import 'package:quaran_app/view/prayertimes/prayertimesview.dart';
import 'package:quaran_app/view/widgets/home/athkar/athkarhomepage.dart';
import 'package:quaran_app/view/widgets/home/featurecard.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        // Quran Feature
        FeatureCard(
          title: 'القرآن الكريم',
          subtitle: 'Read all 114 Surahs',
          icon: Icons.menu_book,
          color: AppColors.quranColor,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QuranViewSelectionPage()
            ));
          },
        ),
        
        // Hadith Feature
        FeatureCard(
          title: 'الأحاديث',
          subtitle: 'Collection of Hadiths',
          icon: Icons.history_edu,
          color: AppColors.hadithColor,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Hadithpage()
            ));
          },
        ),
        
        // Athkar Feature
        FeatureCard(
          title: 'الأذكار اليومية',
          subtitle: 'Daily prayer schedule',
          icon: Icons.access_time,
          color: AppColors.prayerColor,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AthkarHomePage()
            ));
          },
        ),
        
        // Qibla Direction Feature
        FeatureCard(
          title: 'اتجاه القبلة',
          subtitle: 'Find the Qibla',
          icon: Icons.explore,
          color: AppColors.qiblaColor,
          onTap: () {
            Navigator.of(context).pushNamed('/qibla');
          },
        ),
        
        // Prayer Times Feature
        FeatureCard(
          title: 'مواعيد الصلاة',
          subtitle: 'Prayer times',
          icon: Icons.timer,
          color: AppColors.accent,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PrayerTimesPage()
            ));
          },
        ),
        
        // Additional Feature (if needed)
        FeatureCard(
          title: 'المزيد',
          subtitle: 'Coming soon',
          icon: Icons.more_horiz,
          color: AppColors.primary,
          onTap: () {
            // Placeholder for future feature
          },
        ),
      ],
    );
  }
}