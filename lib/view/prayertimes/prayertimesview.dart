import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quaran_app/controller/cubit/prayertimes_cubit.dart';
import 'package:quaran_app/model/prayertimes.dart';
import 'package:quaran_app/view/prayertimes/qibla_page.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({Key? key}) : super(key: key);

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _backgroundAnimationController;
  late Animation<Color?> _backgroundAnimation;
  String region = '';
  late DateTime today;

  // Prayer times placeholder data (will be replaced by your API data)
  final Map<String, String> _prayerTimes = {
    'Fajr': '--:--',
    'Sunrise': '--:--',
    'Dhuhr': '--:--',
    'Asr': '--:--',
    'Maghrib': '--:--',
    'Isha': '--:--',
  };

  String nextPrayer = '';
  String currentDateEn = '';
  String weekday = '';
  String _hijriDate = '';
  void getCurrentDates() {
    final now = DateTime.now();
    today = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
  }

  @override
  void initState() {
    super.initState();
    context.read<PrayertimesCubit>().getPrayertimes();
    getCurrentDates();
    _setupBackgroundAnimation();
    _loadPrayerTimes();
  }

  void _setupBackgroundAnimation() {
    _backgroundAnimationController = AnimationController(
      duration: const Duration(hours: 24),
      vsync: this,
    );

    _backgroundAnimation = ColorTween(
      begin: const Color(0xFF1F2B49), // Night blue
      end: const Color(0xFF4A6572), // Day blue-gray
    ).animate(_backgroundAnimationController);

    // Set animation value based on current time
    final now = DateTime.now();
    final secondsInDay = 24 * 60 * 60;
    final secondsSinceMidnight =
        now.hour * 60 * 60 + now.minute * 60 + now.second;
    _backgroundAnimationController.value = secondsSinceMidnight / secondsInDay;

    // Start animation
    _backgroundAnimationController.repeat();
    _backgroundAnimationController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadPrayerTimes() async {
    // THIS IS WHERE YOU'LL ADD YOUR API CALL
    // Example:
    // final prayerTimesResponse = await yourApiService.getEgyptPrayerTimes();
    // setState(() {
    //   _prayerTimes['Fajr'] = prayerTimesResponse.fajr;
    //   _prayerTimes['Sunrise'] = prayerTimesResponse.sunrise;
    //   _prayerTimes['Dhuhr'] = prayerTimesResponse.dhuhr;
    //   _prayerTimes['Asr'] = prayerTimesResponse.asr;
    //   _prayerTimes['Maghrib'] = prayerTimesResponse.maghrib;
    //   _prayerTimes['Isha'] = prayerTimesResponse.isha;
    // });
    BlocBuilder<PrayertimesCubit, PrayertimesState>(
      builder: (context, state) {
        if (state is PrayertimesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PrayertimesLoaded) {
          _prayerTimes['Fajr'] = state.prayertimes['Fajr'];
          _prayerTimes['Sunrise'] = state.prayertimes['Sunrise'];
          _prayerTimes['Dhuhr'] = state.prayertimes['Dhuhr'];
          _prayerTimes['Asr'] = state.prayertimes['Asr'];
          _prayerTimes['Maghrib'] = state.prayertimes['Maghrib'];
          _prayerTimes['Isha'] = state.prayertimes['Isha'];
          region = state.region;
          currentDateEn = state.date['date_en'];
          weekday = state.date['date_hijri']['weekday']['ar'];
          _hijriDate = state.date['date_hijri']['date'];
        } else if (state is PrayertimesError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  String _determineNextPrayer() {
    // This would be implemented based on current time and prayer times
    // For now, we'll just set a placeholder
    if (today.hour >= 22) {
      nextPrayer = 'Fajr';
      return nextPrayer;
    } else if (today.hour >= 20) {
      nextPrayer = 'Isha';
      return nextPrayer;
    } else if (today.hour >= 17) {
      nextPrayer = 'Maghrib';
      return nextPrayer;
    } else if (today.hour >= 13) {
      nextPrayer = 'Asr';
      return nextPrayer;
    } else if (today.hour >= 7) {
      nextPrayer = 'Dhuhr';
      return nextPrayer;
    } else if (today.hour >= 5) {
      nextPrayer = 'Sunrise';
      return nextPrayer;
    } else {
      nextPrayer = 'Fajr';
      return nextPrayer;
    }

    // IMPLEMENT YOUR LOGIC HERE to determine next prayer
    // Example:
    // final now = DateTime.now();
    // final currentTimeString = DateFormat('HH:mm').format(now);
    // ... compare with prayer times to find next prayer
  }

  @override
  void dispose() {
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _backgroundAnimation.value ?? const Color(0xFF1F2B49),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                  child: BlocBuilder<PrayertimesCubit, PrayertimesState>(
                builder: (context, state) {
                  if (state is PrayertimesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PrayertimesLoaded) {
                    _prayerTimes['Fajr'] = state.prayertimes['Fajr'];
                    _prayerTimes['Sunrise'] = state.prayertimes['Sunrise'];
                    _prayerTimes['Dhuhr'] = state.prayertimes['Dhuhr'];
                    _prayerTimes['Asr'] = state.prayertimes['Asr'];
                    _prayerTimes['Maghrib'] = state.prayertimes['Maghrib'];
                    _prayerTimes['Isha'] = state.prayertimes['Isha'];
                    region = state.region;
                    currentDateEn = state.date['date_en'];
                    weekday = state.date['date_hijri']['weekday']['ar'];
                    _hijriDate = state.date['date_hijri']['date'];
                    return _buildPrayerTimesView();
                  } else if (state is PrayertimesError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              )),
            ),
          );
        });
  }

  Widget _buildPrayerTimesView() {
    return RefreshIndicator(
      onRefresh: _loadPrayerTimes,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          // Egypt and date header
          _buildLocationHeader(),
          const SizedBox(height: 24),

          // Prayer countdown card
          _buildNextPrayerCard(),
          const SizedBox(height: 24),

          // All prayer times
          _buildAllPrayerTimes(),
          const SizedBox(height: 16),

          // Qibla Direction Button
          _buildQiblaButton(),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                  size: 25,
                )),
            const Icon(
              Icons.location_on,
              color: Colors.white70,
              size: 25,
            ),
            const SizedBox(width: 4),
            Text(
              region,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          currentDateEn,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _hijriDate,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildNextPrayerCard() {
    // Debug: Log prayer times

    // Safe null handling
    final nextTime = _prayerTimes?[nextPrayer] ?? '--:--';
    String nextPrayerName;

    try {
      nextPrayerName = _determineNextPrayer();
    } catch (e) {
      nextPrayerName = "Error";
      print("Failed to determine next prayer: $e");
    }

    return Card(
      elevation: 4,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Next Prayer",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 12),
            Text(nextPrayerName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(nextTime,
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2)),
            const SizedBox(height: 16),
            // COUNTDOWN TIMER (FIXED)
            StreamBuilder<DateTime>(
              initialData: DateTime.now(), 
              stream: Stream.periodic(
                const Duration(seconds: 1),
                (_) => DateTime.now(), // Emits current time every second
              ),
              builder: (context, snapshot) {
                // Handle errors first
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                // Show progress indicator while waiting for first data
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(color: Colors.white);
                }

                // SAFE: snapshot.data is now guaranteed non-null
                final currentTime = DateTime.now();
                return Text(
                  "${currentTime.hour.toString().padLeft(2, '0')}:"
                  "${currentTime.minute.toString().padLeft(2, '0')}:"
                  "${currentTime.second.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            const Text("hours   minutes   seconds",
                style: TextStyle(color: Colors.white54, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildAllPrayerTimes() {
    return Card(
      elevation: 4,
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 12),
              child: Text(
                "Prayer Times",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ..._prayerTimes.entries.map((entry) {
              final isNext = entry.key == nextPrayer;
              return _buildPrayerTimeItem(
                prayer: entry.key,
                time: entry.value,
                isHighlighted: isNext,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeItem({
    required String prayer,
    required String time,
    bool isHighlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isHighlighted
            ? Colors.amber.withOpacity(0.2)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted
            ? Border.all(color: Colors.amber.withOpacity(0.5), width: 1)
            : null,
      ),
      child: Row(
        children: [
          // Prayer icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isHighlighted
                  ? Colors.amber.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getPrayerIcon(prayer),
              color: isHighlighted ? Colors.amber : Colors.white70,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          // Prayer name
          Text(
            prayer,
            style: TextStyle(
              color: isHighlighted ? Colors.amber : Colors.white,
              fontSize: 16,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          // Prayer time
          Text(
            time,
            style: TextStyle(
              color: isHighlighted ? Colors.amber : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPrayerIcon(String prayer) {
    // Map prayer names to appropriate icons
    switch (prayer) {
      case 'Fajr':
        return Icons.nightlight_round;
      case 'Sunrise':
        return Icons.wb_sunny_outlined;
      case 'Dhuhr':
        return Icons.wb_sunny;
      case 'Asr':
        return Icons.wb_twighlight;
      case 'Maghrib':
        return Icons.wb_twilight;
      case 'Isha':
        return Icons.nights_stay;
      default:
        return Icons.access_time;
    }
  }

  Widget _buildQiblaButton() {
    return Card(
      elevation: 4,
      color: Colors.green[700]?.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QiblaDirectionPage()));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[700]?.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.compass_calibration,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Qibla Direction",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
