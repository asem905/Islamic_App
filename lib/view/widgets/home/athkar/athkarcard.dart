import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';

class AthkarCard extends StatelessWidget {
  final int id;
  final String arabicText;
  //final String translationText;
  final int repeatCount;
  //final bool isFavorite;
  // final Function(bool) onFavoriteToggle;

  const AthkarCard({
    Key? key,
    required this.id,
    required this.arabicText,
    //required this.translationText,
    required this.repeatCount,
    //required this.isFavorite,
    //required this.onFavoriteToggle,
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
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                decoration: BoxDecoration(
                  color: isDarkMode 
                      ? AppColors.primaryDark.withOpacity(0.4) 
                      : AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                ),
                child: Text(
                  arabicText,
                  style: TextStyle(
                    fontSize: AppDimensions.fontXLarge,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingSmall,
                      vertical: AppDimensions.spacingXSmall,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode 
                          ? AppColors.primaryDark.withOpacity(0.3) 
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                    ),
                    child: Text(
                      '${AppStrings.repeatLabel} $repeatCount ${AppStrings.times}',
                      style: TextStyle(
                        fontSize: AppDimensions.fontMedium,
                        color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy),
                        color: isDarkMode ? AppColors.textLight : AppColors.primary,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: arabicText));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied to clipboard'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     isFavorite ? Icons.favorite : Icons.favorite_border,
                      //     color: isFavorite ? Colors.red : isDarkMode ? AppColors.textLight : AppColors.primary,
                      //   ),
                      //   onPressed: () {
                      //     onFavoriteToggle(!isFavorite);
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}