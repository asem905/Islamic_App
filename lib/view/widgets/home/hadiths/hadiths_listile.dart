import 'package:flutter/material.dart';
import 'package:quaran_app/constant/color.dart';

// Updated to follow Dart naming conventions
class HadithListTile extends StatelessWidget {
  final String hadithStatus;
  final String hadithTextArabic;
  final String hadithTextEnglish;
  final String hadithBookSlug;
  final String hadithNumber;
  final String hadithTranslation;
  
  const HadithListTile({
    super.key,
    required this.hadithStatus,
    required this.hadithTextArabic,
    required this.hadithTextEnglish,
    required this.hadithBookSlug,
    required this.hadithNumber,
    required this.hadithTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with number and book info
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      hadithNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                            
                        Text(
                          hadithBookSlug=="sahih-bukhari"?"صحيح البخاري":hadithBookSlug=="sahih-muslim"?"صحيح مسلم":hadithBookSlug=="al-tirmidhi"?"سنن الترمذي":hadithBookSlug=="musnad-ahmad"?"مسند أحمد":"غير معروف",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(hadithStatus),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hadithStatus=="Sahih"?"صحيح":hadithStatus=="Hasan"?"حسن":hadithStatus=="Daif"?"ضعيف":hadithStatus=="Maudu"?"موضوع":"غير معروف",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const Divider(height: 24),
              
              // Arabic Text (always display with proper direction)
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  hadithTextArabic,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontFamily: 'Scheherazade', // Make sure to add this font to your pubspec.yaml
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // English Translation
              Text(
                hadithTextEnglish,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    status = status.toLowerCase();
    
    if (status.contains('sahih') || status.contains('authentic')) {
      return Colors.green[700]!;
    } else if (status.contains('hasan') || status.contains('good')) {
      return Colors.blue[700]!;
    } else if (status.contains('daif') || status.contains('weak')) {
      return Colors.orange[700]!;
    } else if (status.contains('maudu') || status.contains('fabricated')) {
      return Colors.red[700]!;
    } else {
      return Colors.grey[700]!;
    }
  }
}