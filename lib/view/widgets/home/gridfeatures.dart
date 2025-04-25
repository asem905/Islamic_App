import 'package:flutter/material.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/view/hadithpage.dart';
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
          title: 'Quran',
          subtitle: 'Read all 114 Surahs',
          icon: Icons.menu_book,
          color: AppColors.quranColor,
          onTap: () {
            Navigator.of(context).pushNamed('/surahsList');
          },
        ),
        
        // Hadith Feature
        FeatureCard(
          title: 'Hadith',
          subtitle: 'Collection of Hadiths',
          icon: Icons.history_edu,
          color: AppColors.hadithColor,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Hadithpage()));
          },
        ),
        
        // Prayer Times Feature
        FeatureCard(
          title: 'Prayer Times',
          subtitle: 'Daily prayer schedule',
          icon: Icons.access_time,
          color: AppColors.prayerColor,
          onTap: () {
            // Navigate to Prayer times
          },
        ),
        
        // Qibla Direction Feature
        FeatureCard(
          title: 'Qibla Direction',
          subtitle: 'Find the Qibla',
          icon: Icons.explore,
          color: AppColors.qiblaColor,
          onTap: () {
            // Navigate to Qibla direction
          },
        ),
      ],
    );
  }
}
