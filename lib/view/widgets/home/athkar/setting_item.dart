import 'package:flutter/material.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingCard({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMedium),
      elevation: AppDimensions.elevationSmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMedium,
          vertical: AppDimensions.spacingSmall,
        ),
        leading: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingSmall),
          decoration: BoxDecoration(
            color: isDarkMode 
                ? AppColors.primary.withOpacity(0.2) 
                : AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon, 
            color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
            size: AppDimensions.iconMedium,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColors.textLight : AppColors.textDark,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}