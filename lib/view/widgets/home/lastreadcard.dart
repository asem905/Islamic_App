import 'package:flutter/material.dart';
import 'package:quaran_app/constant/color.dart';

class LastReadCard extends StatelessWidget {
  final String surahName;
  final VoidCallback onTap;
  final int? ayahNumber;
  final String text;
  const LastReadCard({
    super.key,
    this.ayahNumber,
    required this.surahName,
    required this.onTap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.accent.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.bookmark,
                color: AppColors.accent,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.textLight.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    surahName,
                    style: const TextStyle(
                      color: AppColors.textLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ayahNumber != null
                      ? Text(
                          'آيه رقم $ayahNumber',
                          style: const TextStyle(
                            color: AppColors.textLight,
                            fontSize: 16,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.play_circle_filled,
                color: AppColors.accent,
                size: 36,
              ),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
