import 'package:flutter/material.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';

class CounterSection extends StatelessWidget {
  final int counter;
  final VoidCallback onReset;
  final VoidCallback onDecrement;
  final AnimationController animationController;

  const CounterSection({
    Key? key,
    required this.counter,
    required this.onReset,
    required this.onDecrement,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingLarge),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLarge),
          topRight: Radius.circular(AppDimensions.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLarge,
              vertical: AppDimensions.spacingMedium,
            ),
            decoration: BoxDecoration(
              color: isDarkMode 
                  ? AppColors.athkarprimaryDark.withOpacity(0.3) 
                  : AppColors.athkarprimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Text(
              '${AppStrings.counterLabel} $counter',
              style: TextStyle(
                fontSize: AppDimensions.fontXLarge,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppColors.athkartextLight : AppColors.athkarprimary,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  foregroundColor: isDarkMode ? AppColors.athkartextLight : AppColors.athkartextDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingLarge,
                    vertical: AppDimensions.spacingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text(AppStrings.resetButton),
              ),
              const SizedBox(width: AppDimensions.spacingLarge),
              ScaleTransition(
                scale: Tween<double>(begin: 1, end: 1.2).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Curves.elasticOut,
                  ),
                ),
                child: ElevatedButton.icon(
                  onPressed: onDecrement,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? AppColors.athkarprimaryLight : AppColors.athkarprimary,
                    foregroundColor: AppColors.athkartextLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingXLarge,
                      vertical: AppDimensions.spacingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text(
                    AppStrings.readButton,
                    style: TextStyle(fontSize: AppDimensions.fontLarge),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}