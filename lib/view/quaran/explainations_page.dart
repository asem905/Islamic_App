import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/controller/cubit/tafseer_cubit.dart';

class ExplanationPage extends StatefulWidget {
  final String title;
  final String ayahNumber;
  
  const ExplanationPage({
    Key? key, 
    required this.title,
    required this.ayahNumber,
  }) : super(key: key);

  @override
  State<ExplanationPage> createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  late ScrollController _scrollController;
  bool _showAppBarTitle = false;
  List SurahsName=[
    'الفاتحة',
    'البقرة',
    'آل عمران',
    'النساء',
    'المائدة',
    'الأنعام',
    'الأعراف',
    'الأنفال',
    'التوبة',
    'يونس',
    'هود',
    'يوسف',
    'الرعد',
    'إبراهيم',
    'الحجر',
    'النحل',
    'الإسراء',
    'الكهف',
    'مريم',
    'طه',
    'الأنبياء',
    'الحج',
    'المؤمنون',
    'النّور',
    'الفرقان',
    'الشعراء',
    'النّمل',
    'القصص',
    'العنكبوت',
    'الرّوم',
    'لقمان',
    'السجدة',
    'الاحزاب',
    'سبأ',
    'فاطر',
    'يس',
    'الصافات',
    'ص',
    'الزمر',    
    'غافر',
    'فصلت',
    'الشورى',    
    'الزخرف',
    'الدخان',
    'الجاثية',
    'الاحقاف',
    'محمد',
    'الفتح',    
    'الحجرات',
    'ق',
    'الذاريات',
    'الطور',
    'النجم',
    'القمر',
    'الرحمن',
    'الواقعة',
    'الحديد',
    'المجادلة',    
    'الحشر',
    'الممتحنة',
    'الصف',
    'الجمعة',
    'المنافقون',
    'التغابن',
    'الطلاق',
    'التحريم',
    'الملك',
    'القلم',
    'الحاقة',
    'المعارج',
    'نوح',
    'الجن',
    'المزّمّل',
    'المدّثر',
    'القيامة',
    'الإنسان',
    'المرسلات',
    'النبأ',
    'النازعات',
    'عبس',
    'التكوير',
    'الإنفطار',
    'المطفّفين',
    'الإنشقاق',
    'البروج',
    'الطارق',
    'الأعلى',
    'الغاشية',
    'الفجر',
    'البلد',
    'الشمس',
    'الليل',
    'الضحى',
    'الشرح',
    'التين',
    'العلق',
    'القدر',
    'البينة',
    'الزلقة',
    'العاديات',
    'القارعة',
    'التكاثر',
    'العصر',
    'الهمزة',
    'الفيل',
    'قريش',
    'الماعون',
    'الكوثر',
    'الكافرون',
    'النصر',
    'المسد',
    'الإخلاص',
    'الفلق',
    'الناس',
  ];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    context.read<TafseerCubit>().getTafseer(1, int.parse(widget.title), int.parse(widget.ayahNumber));
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
  
  void _scrollListener() {
    if (_scrollController.offset > 100 && !_showAppBarTitle) {
      setState(() => _showAppBarTitle = true);
    } else if (_scrollController.offset <= 100 && _showAppBarTitle) {
      setState(() => _showAppBarTitle = false);
    }
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _showAppBarTitle ? Colors.green : Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _showAppBarTitle 
            ? Text(widget.title, style: const TextStyle(color: Colors.white))
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildHeader(),
          _buildContent(),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(

        color: Colors.green,
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "سوره ${SurahsName[int.parse(widget.title)-1]}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "آية ${widget.ayahNumber}",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContent() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArabicSection(),
          // _buildTranslation(),
          // _buildExplanation(),
        ],
      ),
    );
  }
  
  Widget _buildArabicSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<TafseerCubit, TafseerState>(
        builder: (context, state) {
          if (state is TafseerLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(color: Colors.green),
              ),
            );
          } else if (state is TafseerLoaded) {
            return Column(
              children: [
                Text(
                  state.tafseerMap['tafseer_name'] ?? '',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    state.tafseerMap['text'] ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'ArabicFont',
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else if (state is TafseerError) {
            return Text(
              state.error,
              style: const TextStyle(color: Colors.red),
            );
          } else {
            return const Text(
              'No data available',
              style: TextStyle(color: Colors.grey),
            );
          }
        },
      ),
    );
  }
  
  Widget _buildTranslation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Translation'),
          const SizedBox(height: 10),
          Text(
            'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildExplanation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Explanation'),
          const SizedBox(height: 15),
          Text(
            'This sacred phrase begins almost every chapter of the Quran except for the ninth chapter. It is a reminder to start all deeds by invoking the name of Allah.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'The phrase invokes the attributes of mercy that Allah possesses, affirming that His mercy encompasses all creation (الرَّحْمَٰنِ) and is especially reserved for the believers (الرَّحِيمِ).',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.green.shade700,
                  width: 3,
                ),
              ),
              color: Colors.grey.shade50,
            ),
            child: Text(
              'Ibn Kathir explains that the Bismillah serves as a blessing and seeking of help from Allah before engaging in any significant matter.',
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade800,
        ),
      ),
    );
  }
  
  Widget _buildBottomNav() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.format_size, color: Colors.green.shade700),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.dark_mode, color: Colors.green.shade700),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.headset, color: Colors.green.shade700),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.green.shade700),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}