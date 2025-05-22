import 'package:flutter/material.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/home.dart';

class HeaderAthkar extends StatelessWidget {
  const HeaderAthkar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingMedium),
      margin: const EdgeInsets.only(
        top: AppDimensions.spacingMedium, 
        bottom: AppDimensions.spacingLarge
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>HomePage()));
                  }, icon:const Icon(Icons.arrow_back,size: 30,)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    'Athkar',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: isDarkMode ? AppColors.textLight : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXSmall),
                  Text(
                    'Daily Islamic Remembrances',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? AppColors.primaryLight : AppColors.primary.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(AppDimensions.spacingSmall),
                child: Icon(
                  Icons.menu_book_rounded,
                  size: AppDimensions.iconLarge,
                  color: isDarkMode ? AppColors.textLight : AppColors.primary,
                ),
              ),

            ],
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMedium,
              vertical: AppDimensions.spacingSmall,
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: isDarkMode ? AppColors.textSecondary : AppColors.primary,
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Athkar...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                    ),
                    style: TextStyle(
                      color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}