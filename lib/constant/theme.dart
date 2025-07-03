// lib/core/theme/theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme:const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      background: AppColors.background,
      surface: AppColors.cardLight,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textDark,
      onBackground: AppColors.textDark,
      onSurface: AppColors.textDark,
    ),
    scaffoldBackgroundColor: AppColors.background,
    cardTheme: CardTheme(
      elevation: AppDimensions.elevationSmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppDimensions.fontHuge,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
      displayMedium: TextStyle(
        fontSize: AppDimensions.fontXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
      bodyLarge: TextStyle(
        fontSize: AppDimensions.fontLarge,
        color: AppColors.textDark,
      ),
      bodyMedium: TextStyle(
        fontSize: AppDimensions.fontMedium,
        color: AppColors.textDark,
      ),
      bodySmall: TextStyle(
        fontSize: AppDimensions.fontSmall,
        color: AppColors.textSecondary,
      ),
    ),
    tabBarTheme:const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.textLight,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle:  TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppDimensions.elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme:const ColorScheme.dark(
      primary: AppColors.primaryLight,
      secondary: AppColors.accentLight,
      background: AppColors.backgroundDark,
      surface: AppColors.cardDark,
      onPrimary: AppColors.textLight,
      onSecondary: AppColors.textLight,
      onBackground: AppColors.textLight,
      onSurface: AppColors.textLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardTheme: CardTheme(
      elevation: AppDimensions.elevationSmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      color: AppColors.cardDark,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppDimensions.fontHuge,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight,
      ),
      displayMedium: TextStyle(
        fontSize: AppDimensions.fontXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight,
      ),
      bodyLarge: TextStyle(
        fontSize: AppDimensions.fontLarge,
        color: AppColors.textLight,
      ),
      bodyMedium: TextStyle(
        fontSize: AppDimensions.fontMedium,
        color: AppColors.textLight,
      ),
      bodySmall: TextStyle(
        fontSize: AppDimensions.fontSmall,
        color: AppColors.textSecondary,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.textLight,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppDimensions.elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.textLight,
      elevation: 0,
      centerTitle: true,
    ),
  );
}