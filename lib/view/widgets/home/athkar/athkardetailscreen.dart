import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/view/widgets/home/athkar/counterathkar.dart';

class AthkarDetailScreen extends StatefulWidget {
  final int id;
  final String title;
  final String arabicText;
  final String translationText;
  final int repeatCount;
  final String source;
  final Color color;

  const AthkarDetailScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.arabicText,
    required this.translationText,
    required this.repeatCount,
    required this.source,
    required this.color,
  }) : super(key: key);

  @override
  State<AthkarDetailScreen> createState() => _AthkarDetailScreenState();
}

class _AthkarDetailScreenState extends State<AthkarDetailScreen> with SingleTickerProviderStateMixin {
  late int _counter;
  late AnimationController _animationController;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _counter = widget.repeatCount;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _resetCounter() {
    setState(() {
      _counter = widget.repeatCount;
      _completed = false;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      HapticFeedback.lightImpact();
      _animationController.forward(from: 0.0);
      
      setState(() {
        _counter--;
        if (_counter == 0) {
          _completed = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(
                text: '${widget.arabicText}\n\n${widget.translationText}',
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to clipboard'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Content area
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.spacingMedium),
              children: [
                // Completion alert
                if (_completed)
                  Container(
                    margin: const EdgeInsets.only(bottom: AppDimensions.spacingLarge),
                    padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: widget.color,
                          size: AppDimensions.iconLarge,
                        ),
                        const SizedBox(width: AppDimensions.spacingMedium),
                        Expanded(
                          child: Text(
                            AppStrings.completionMessage,
                            style: TextStyle(
                              fontSize: AppDimensions.fontMedium,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Arabic text
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: AppDimensions.spacingLarge),
                  padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.arabicText,
                    style: TextStyle(
                      fontSize: AppDimensions.fontXXLarge,
                      height: 1.8,
                      color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),

                // Translation text
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: AppDimensions.spacingLarge),
                  padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Translation',
                        style: TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingMedium),
                      Text(
                        widget.translationText,
                        style: TextStyle(
                          fontSize: AppDimensions.fontLarge,
                          height: 1.5,
                          color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),

                // Source information
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: AppDimensions.spacingLarge),
                  padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Source',
                        style: TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingMedium),
                      Text(
                        widget.source,
                        style: TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          fontStyle: FontStyle.italic,
                          color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Counter section
          CounterSection(
            counter: _counter,
            onReset: _resetCounter,
            onDecrement: _decrementCounter,
            animationController: _animationController,
          ),
        ],
      ),
    );
  }
}