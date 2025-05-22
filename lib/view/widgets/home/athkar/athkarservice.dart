import 'package:flutter/material.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';

// Placeholder service - replace with actual API integration
class AthkarService {
  // Method to fetch athkar categories
  static Future<List<Map<String, dynamic>>> getCategories() async {
    // Placeholder data until API integration
    return [
      {
        'title': AppStrings.morningAthkar,
        'icon': Icons.wb_sunny,
        'color': AppColors.morningColor,
      },
      {
        'title': AppStrings.eveningAthkar,
        'icon': Icons.nightlight_round,
        'color': AppColors.eveningColor,
      },
      {
        'title': AppStrings.prayerAthkar,
        'icon': Icons.mosque,
        'color': AppColors.prayerColor,
      },
      {
        'title': AppStrings.sleepAthkar,
        'icon': Icons.bedtime,
        'color': AppColors.sleepColor,
      },
      {
        'title': AppStrings.wakeUpAthkar,
        'icon': Icons.wb_sunny,
        'color': AppColors.wakeupColor,
      },
      {
        'title': AppStrings.mosqueAthkar,
        'icon': Icons.mosque,
        'color': AppColors.mosqueColor,
      },
      {
        'title': AppStrings.miscellaneousAzkar,
        'icon': Icons.mail_rounded,
        'color': AppColors.occasionsColor,
      },
      {
        'title': AppStrings.azanAzkar,
        'icon': Icons.query_builder,
        'color': AppColors.azanColor,
      },
      {
        'title': AppStrings.khalaAzkar,
        'icon': Icons.store_mall_directory_outlined,
        'color': AppColors.khalaColor,
      },
      {
        'title': AppStrings.wuduAzkar,
        'icon': Icons.mosque_outlined,
        'color': AppColors.wuduColor,
      },
      {
        'title': AppStrings.hajjAndUmrahAzkar,
        'icon': Icons.mosque_outlined,
        'color': AppColors.athkarprayerColor,
      }
    ];
  }

  // Method to fetch athkar items for a specific category
 
  // Method to toggle favorite status
  static Future<bool> toggleFavorite(int id, bool isFavorite) async {
    // Placeholder until API integration
    return !isFavorite;
  }

  // Method to get favorite athkar
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    // Placeholder until API integration
    return [];
  }
}