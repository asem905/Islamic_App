// lib/core/constants/constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Athkar App';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseApiUrl = 'https://your-api-endpoint.com/api';
  static const String athkarEndpoint = '$baseApiUrl/athkar';
  
  // Asset Paths
  static const String assetsPath = 'assets/';
  static const String imagesPath = '${assetsPath}images/';
  static const String lottiePath = '${assetsPath}lottie/';
  
  // Route Names
  static const String homeRoute = '/home';
  static const String athkarListRoute = '/athkar-list';
  static const String athkarDetailRoute = '/athkar-detail';
  static const String settingsRoute = '/settings';
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // Storage Keys
  static const String themePreferenceKey = 'theme_preference';
  static const String languagePreferenceKey = 'language_preference';
  static const String fontSizePreferenceKey = 'font_size_preference';
  static const String favoriteAthkarKey = 'favorite_athkar';
  static const String notificationsEnabledKey = 'notifications_enabled';
}


class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  
  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  
  // Special Styles
  static const TextStyle arabicText = TextStyle(
    fontFamily: 'Amiri',
    fontSize: 22,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );
  
  static const TextStyle translationText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontStyle: FontStyle.italic,
    height: 1.4,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  
  static const TextStyle tabBarLabel = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );
  
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle captionText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}

class AppSizes {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 40.0;
  
  // Margins
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;
  static const double marginXXL = 40.0;
  
  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  
  // Icon Sizes
  static const double iconXS = 14.0;
  static const double iconS = 18.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;
  
  // Button Sizes
  static const double buttonHeight = 48.0;
  static const double buttonMinWidth = 120.0;
  
  // Card Sizes
  static const double cardElevation = 2.0;
  static const double cardBorderRadius = 16.0;
  
  // TabBar
  static const double tabBarHeight = 56.0;
  static const double tabBarRadius = 28.0;
}

class AppDurations {
  static const Duration fastest = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 700);
  static const Duration slowest = Duration(milliseconds: 1000);
}


class AppDimensions {
  // Padding and margin
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 15.0;
  static const double radiusLarge = 25.0;
  static const double radiusXLarge = 30.0;
  
  // Card elevation
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  
  // Icon sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Font sizes
  static const double fontSmall = 12.0;
  static const double fontMedium = 14.0;
  static const double fontLarge = 16.0;
  static const double fontXLarge = 18.0;
  static const double fontXXLarge = 24.0;
  static const double fontHuge = 32.0;
}

class AppStrings {
  // Tab Names
  static const String categoriesTab = 'Categories';
  static const String favoritesTab = 'Favorites';
  static const String settingsTab = 'Settings';
  
  // Category Names
  static const String morningAthkar = 'أذكار الصباح';
  static const String eveningAthkar = 'أذكار المساء';
  static const String prayerAthkar = 'أذكار الصلاة';
  static const String sleepAthkar = 'أذكار النوم';
  static const String wakeUpAthkar='أذكار الاستيقاظ';
  static const String mosqueAthkar = 'أذكار دخول المسجد';
  static const String miscellaneousAzkar='أذكار المناسبات';
  static const String azanAzkar ='أذكار الأذان';
  static const String wuduAzkar='أذكار الوضوء';
  static const String khalaAzkar='أذكار الخلاء';
  static const String hajjAndUmrahAzkar='أذكار الحج والعمرة';
  // Settings
  static const String notifications = 'Notifications';
  static const String darkMode = 'Dark Mode';
  static const String language = 'Language';
  static const String fontSize = 'Font Size';
  static const String about = 'About';
  
  // Messages
  static const String favoritesEmptyMessage = 'Your favorite Athkar will appear here';
  static const String completionMessage = 'Completed! May Allah accept your devotion.';
  static const String counterLabel = 'Remaining: ';
  static const String resetButton = 'Reset';
  static const String readButton = 'Read';
  static const String repeatLabel = 'Repeat: ';
  static const String times = 'times';
  static const String basmalah = 'بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ';
  static const String sourceLabel = 'Source: ';
  
  // Error Messages
  static const String errorLoadingData = 'Error loading data: ';
  static const String errorLoadingAthkar = 'Error loading athkar: ';
}