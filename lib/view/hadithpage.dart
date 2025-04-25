import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/cubit/hadiths_cubit.dart';
import 'package:shimmer/shimmer.dart';

class Hadithpage extends StatefulWidget {
  const Hadithpage({super.key});

  @override
  State<Hadithpage> createState() => _HadithpageState();
}

class _HadithpageState extends State<Hadithpage> with SingleTickerProviderStateMixin {
  int currentPage = 1;
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSearch = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  final List<String> hadithCollections = [
    "صحيح مسلم",
    "صحيح البخاري",
    "الترمذي",
    "أبو داود",
    "احمد"
  ];

  @override
  void initState() {
    context.read<HadithsCubit>().fetchHadiths(currentPage, null);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      isSearch = !isSearch;
      if (isSearch) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        searchController.clear();
        context.read<HadithsCubit>().fetchHadiths(currentPage, null);
      }
    });
  }

  void _searchHadith(String query) {
    if (query.isEmpty) return;
    
    String searchTerm;
    if (query == "صحيح مسلم" || query == "مسلم" || query.toLowerCase() == "muslim") {
      searchTerm = "sahih-muslim";
    } else if (query == "صحيح البخاري" || query == "البخاري" || query.toLowerCase() == "bukhari") {
      searchTerm = "sahih-bukhari";
    } else if (query == "الترمذى" || query == "الترمذي" || query.toLowerCase() == "al tirmidhi") {
      searchTerm = "al-tirmidhi";
    } else if (query == "أبو داود" || query.toLowerCase() == "abu dawood") {
      searchTerm = "abu-dawood";
    } else if (query == "احمد" || query.toLowerCase() == "ahmed") {
      searchTerm = "musnad-ahmad";
    } else {
      searchTerm = query;
    }
    
    context.read<HadithsCubit>().fetchHadiths(null, searchTerm);
  }

  Widget _buildCollectionChips() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hadithCollections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ActionChip(
              backgroundColor: AppColors.primaryLight.withOpacity(0.1),
              side: BorderSide(color: AppColors.primaryDark.withOpacity(0.3)),
              avatar: CircleAvatar(
                backgroundColor: AppColors.primaryDark,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              label: Text(
                hadithCollections[index],
                style:const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                searchController.text = hadithCollections[index];
                _searchHadith(hadithCollections[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSearch ? 48 : 0,
              child: isSearch
                  ? IconButton(
                      onPressed: _toggleSearch,
                      icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
                    )
                  : const SizedBox(),
            ),
            Expanded(
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search hadith...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onFieldSubmitted: _searchHadith,
              ),
            ),
            Container(
              height: 42,
              width: 42,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () => _searchHadith(searchController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryDark,
            AppColors.primaryDark.withOpacity(0.85),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: -5,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "الأحاديث النبوية",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.search_ellipsis,
                        progress: _animation,
                        color: Colors.white,
                      ),
                      onPressed: _toggleSearch,
                    ),
                  ),
                ],
              ),
            ),
            
            // Search Bar (only if search is active)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSearch ? null : 0,
              margin: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: isSearch ? 16.0 : 0,
              ),
              child: isSearch ? _buildSearchBar() : const SizedBox(),
            ),
            
            // Collection chips below search bar when search is active
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSearch ? null : 0,
              margin: EdgeInsets.only(
                left: 16.0,
                right: 16.0, 
                top: isSearch ? 8.0 : 0,
              ),
              child: isSearch ? _buildCollectionChips() : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_state.png', // Add this image to your assets
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 16),
          const Text(
            "No hadiths found",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Try a different search term",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<HadithsCubit>().fetchHadiths(currentPage, null);
              searchController.clear();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Reset"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Oops! Something went wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HadithsCubit>().fetchHadiths(currentPage, null);
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Try Again"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHadithCard(int index, hadith) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with source and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryDark.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          hadith.bookSlug! == "sahih-bukhari"? "صحيح البخاري": hadith.bookSlug! == "sahih-muslim"? "صحيح مسلم" : hadith.bookSlug! == "al-tirmidhi"? "الترمذى" : hadith.bookSlug! == "musnad-ahmad"? "احمد" : hadith.bookSlug! == "abu-dawood"? "ابو داود" :"غير معروف" ,
                          style:const TextStyle(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: hadith.status! == "Sahih" 
                              ? Colors.green
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: hadith.status! == "Sahih"
                                ? Colors.green.withOpacity(0.3)
                                : Colors.orange.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              hadith.status! == "Sahih" ? Icons.check_circle : Icons.info_outline,
                              size: 16,
                              color: hadith.status! == "Sahih" ? Colors.white : Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              hadith.status! =="Sahih"?  "صحيح":hadith.status! =="Hasan"? "حسن":hadith.status! =="Hasan"? "ضعيف": hadith.status! =="Da`eef"? "ضعيف": hadith.status! =="Mawdu"?"موضوع":"غير معروف",
                              style: TextStyle(
                                color: hadith.status! == "Sahih" ? Colors.white : Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Arabic text with decorative quotation
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Text(
                          hadith.hadithArabic!,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontFamily: 'Amiri', // Add this Arabic font to your pubspec.yaml
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: Icon(
                          Icons.format_quote,
                          size: 32,
                          color: AppColors.primaryDark.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Divider with hadith number
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Directionality(textDirection: TextDirection.rtl, child: Text(
                          "حديث رقم ${hadith.hadithNumber!} ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),)
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // English translation
                  Text(
                    hadith.hadithEnglish!,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton(
                        Icons.bookmark_border,
                        "Save",
                        Colors.blue,
                        () {},
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(
                        Icons.share,
                        "Share",
                        Colors.green,
                        () {},
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(
                        Icons.copy,
                        "Copy",
                        Colors.purple,
                        () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<HadithsCubit, HadithsState>(
      builder: (context, state) {
        if (state is HadithsLoading) {
          return _buildLoadingShimmer();
        } else if (state is HadithsLoadingError) {
          return _buildErrorState(state.errorMessage);
        } else if (state is HadithsLoaded && state.hadiths.isEmpty) {
          return _buildEmptyState();
        } else if (state is HadithsLoaded) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.hadiths.length,
                itemBuilder: (context, index) {
                  return _buildHadithCard(index, state.hadiths[index]);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<HadithsCubit>().fetchHadiths(++currentPage, null);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child:const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Load More Hadiths", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 8),
                    Icon(Icons.expand_more, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        } else {
          return _buildEmptyState();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildPageHeader(),
          
          // Main content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // Display collections chips when search is not active
                if (!isSearch) ...[
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 8),
                    child: Text(
                      "Popular Collections",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  _buildCollectionChips(),
                  const SizedBox(height: 16),
                ],
                
                _buildContent(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryDark,
        child: const Icon(Icons.filter_list, color: Colors.white),
        onPressed: () {
          // Show filter options
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filter Hadiths",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Filter options would go here
                  const Text("Coming soon..."),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Apply Filters"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}