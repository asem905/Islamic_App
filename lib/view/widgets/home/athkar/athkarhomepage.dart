import 'package:flutter/material.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/view/widgets/home/athkar/athkarservice.dart';
import 'package:quaran_app/view/widgets/home/athkar/category_Screen.dart';
import 'package:quaran_app/view/widgets/home/athkar/categorycard.dart';
import 'package:quaran_app/view/widgets/home/athkar/header.dart';


class AthkarHomePage extends StatefulWidget {
  const AthkarHomePage({Key? key}) : super(key: key);

  @override
  State<AthkarHomePage> createState() => _AthkarHomePageState();
}

class _AthkarHomePageState extends State<AthkarHomePage> {
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final categories = await AthkarService.getCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '${AppStrings.errorLoadingData}$e';
        _isLoading = false;
      });
    }
  }

  void _navigateToCategory(BuildContext context, String categoryTitle, Color categoryColor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          title: categoryTitle,
          color: categoryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadCategories,
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              // Header section
              const SliverToBoxAdapter(
                child: HeaderAthkar(),
              ),
              
              // Categories title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingMedium,
                    vertical: AppDimensions.spacingSmall,
                  ),
                  child: Text(
                    AppStrings.categoriesTab,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: AppDimensions.fontXLarge,
                      color: isDarkMode ? AppColors.textLight : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // Error message if any
              if (_errorMessage.isNotEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                      child: Column(
                        children: [
                          Text(
                            _errorMessage,
                            style:const TextStyle(
                              color: Colors.red,
                              fontSize: AppDimensions.fontMedium,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacingMedium),
                          ElevatedButton(
                            onPressed: _loadCategories,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              
              // Loading indicator
              if (_isLoading)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                
              // Categories grid
              if (!_isLoading && _errorMessage.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppDimensions.spacingMedium,
                      mainAxisSpacing: AppDimensions.spacingMedium,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = _categories[index];
                        return CategoryCard(
                          title: category['title'],
                          icon: category['icon'],
                          color: category['color'],
                          onTap: () => _navigateToCategory(
                            context, 
                            category['title'],
                            category['color'],
                          ),
                        );
                      },
                      childCount: _categories.length,
                    ),
                  ),
                ),
                
              // Bottom spacing for better UX
              const SliverToBoxAdapter(
                child: SizedBox(height: AppDimensions.spacingLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}