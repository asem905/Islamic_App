import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/constant/athkarstyles.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/controller/cubit/athkar_cubit.dart';
import 'package:quaran_app/view/widgets/home/athkar/athkarcard.dart';


class CategoryScreen extends StatefulWidget {
  final String title;
  final Color color;

  const CategoryScreen({
    super.key, 
    required this.title,
    required this.color,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  getRealAzkarName(){
    if(widget.title.contains( 'أذكار الصباح')){
      return 'morningazkar';
    }else if(widget.title.contains('أذكار المساء')){
      return 'eveningazkar';
    }else if(widget.title.contains('أذكار الصلاة')){
      return 'prayerazkar';
    }else if(widget.title.contains('أذكار النوم')){
      return 'sleepazkar';
    }else if(widget.title.contains('أذكار الاستيقاظ')){
      return 'wakeupazkar';
    }else if(widget.title.contains('أذكار دخول المسجد')){
      return 'mosqueazkar';
    }else if(widget.title.contains('أذكار المناسبات')){
      return 'miscellaneousazkar';
    }else if(widget.title.contains('أذكار الأذان')){
      return 'adhanazkar';
    }else if(widget.title.contains('أذكار الوضوء')){
      return 'wuduazkar';
    }else if(widget.title.contains('أذكار المنزل')){
      return 'homeazkar';
    }else if(widget.title.contains('أذكار الخلاء')){
      return 'khalaazkar';
    }else if(widget.title.contains('أذكار الطعام')){
      return 'foodazkar';
    }else if(widget.title.contains('أذكار الحج والعمرة')){
      return 'hajjandumrahazkar';
    }else if(widget.title.contains('أذكار النوم')){
      return 'sleepazkar';
    }else {
      return '';
    }
  }
  @override
  void initState() {
    super.initState();
    _loadAthkar();
  }

  Future<void> _loadAthkar() async {
    print("getRealAzkarName()================================: ${getRealAzkarName()}================================");
    context.read<AthkarCubit>().getAthkar(getRealAzkarName());

  }

  // Future<void> _toggleFavorite(int id, bool currentStatus) async {
  //   try {
  //     final newStatus = await AthkarService.toggleFavorite(id, currentStatus);
  //     setState(() {
  //       final index = _athkarList.indexWhere((item) => item['id'] == id);
  //       if (index != -1) {
  //         _athkarList[index]['is_favorite'] = newStatus;
  //       }
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error updating favorite status: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: Text(widget.title,style:const TextStyle(fontSize: 30),),
        backgroundColor: widget.color,
        elevation: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadAthkar,
          color: widget.color,
          child: CustomScrollView(
            slivers: [
              // Header decoration
              SliverToBoxAdapter(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppDimensions.radiusLarge),
                      bottomRight: Radius.circular(AppDimensions.radiusLarge),
                    ),
                  ),
                ),
              ),

              // Basmalah
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingLarge,
                    horizontal: AppDimensions.spacingMedium,
                  ),
                  child: Text(
                    AppStrings.basmalah,
                    style: TextStyle(
                      fontSize: AppDimensions.fontXLarge,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
                BlocBuilder<AthkarCubit, AthkarState>(builder: (context, state) {
                  if(state is AthkarLoading){
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                          child: CircularProgressIndicator(
                            color: widget.color,
                          ),
                        ),
                      ),
                    );
                  }else if(state is AthkarError){
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimensions.spacingLarge),
                          child: Text(
                            state.errorMessage,
                            style:const TextStyle(
                              color: Colors.red,
                              fontSize: AppDimensions.fontMedium,
                            ),
                          ),
                        ),
                      ),
                    );
                  }else if(state is AthkarMorningLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarMorningList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarMorningList.length,
                      ),
                    );
                  }else if(state is AthkarEveningLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarEveningList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarEveningList.length,
                      ),
                    );

                  }else if (state is AthkarSleepLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarSleepList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarSleepList.length,
                      ),
                    );
                  }else if(state is AthkarPrayerLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarPrayerList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarPrayerList.length,
                      ),
                    );
                  }else if( state is AthkarWakeUpLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarWakeUpList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarWakeUpList.length,
                      ),
                    );
                  
                  
                  }else if(state is AthkarHajjAndUmrahLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarHajjAndUmrahList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarHajjAndUmrahList.length,
                      ),
                    );
                  }else if(state is AthkarWuduLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarWuduList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarWuduList.length,
                      ),
                    );
                  }else if (state is AthkarMosqueLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarMosqueList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarMosqueList.length,
                      ),
                    );
                  }else if(state is AthkarPrayerLaterLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarPrayerLaterList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarPrayerLaterList.length,
                      ),
                    );
                  }else if(state is AthkarKhalaLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarKhalaList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarKhalaList.length,
                      ),
                    );
                  }else if(state is AthkarMiscellaneousLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarMiscellaneousList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarMiscellaneousList.length,
                      ),
                    );
                  }else if( state is AthkarFoodLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarFoodList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarFoodList.length,
                      ),
                    );
                  }else if(state is AthkarAdhanLoaded){
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.athkarAdhanList[index];
                          return AthkarCard(
                            arabicText: item.text!,
                            id: item.id!,
                            repeatCount: item.count!,
                          );
                        },
                        childCount: state.athkarAdhanList.length,
                      ),
                    );
                  }else {
                    return const SliverToBoxAdapter(child: Center(child: Text("No Athkar Found")));
                  }
                }),

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