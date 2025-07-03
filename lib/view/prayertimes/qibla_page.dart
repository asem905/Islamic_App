import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:quaran_app/constant/color.dart';
import 'package:quaran_app/controller/cubit/qibla_cubit.dart';

class QiblaDirectionPage extends StatefulWidget {
  const QiblaDirectionPage({Key? key}) : super(key: key);

  @override
  State<QiblaDirectionPage> createState() => _QiblaDirectionPageState();
}

class _QiblaDirectionPageState extends State<QiblaDirectionPage> {
  double? _compassDirection;
  double? _qiblaDirection;
  bool _isLoading = false;
  String _errorMessage = '';
  StreamSubscription<CompassEvent>? _compassSubscription;
  final TextEditingController _latitudeCont = TextEditingController();
  final TextEditingController _longitudeCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listenToCompass();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    _latitudeCont.dispose();
    _longitudeCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Direction'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<QiblaCubit, QiblaState>(
        listener: (context, state) {
          if (state is QiblaLoading) {
            setState(() => _isLoading = true);
          } else if (state is QiblaLoaded) {
            setState(() {
              _qiblaDirection = state.qiblaDirection;
              _isLoading = false;
              _errorMessage = '';
            });
          } else if (state is QiblaError) {
            setState(() {
              _errorMessage = state.message;
              _isLoading = false;
            });
          }
        },
        child: Column(
          children: [
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red[700]),
                  textAlign: TextAlign.center,
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _latitudeCont,
                      decoration: const InputDecoration(
                        labelText: 'latitude',
                        hintText: 'Enter your location latitude',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _longitudeCont,
                      decoration: const InputDecoration(
                        labelText: 'longitude',
                        hintText: 'Enter your location longitude',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_latitudeCont.text.isEmpty || _longitudeCont.text.isEmpty) {
                        setState(() {
                          _errorMessage = 'Please enter both latitude and longitude';
                        });
                        return;
                      }

                      try {
                        double lat = double.parse(_latitudeCont.text);
                        double lng = double.parse(_longitudeCont.text);
                        context.read<QiblaCubit>().getQibla(lat, lng);
                      } catch (e) {
                        setState(() {
                          _errorMessage = 'Invalid latitude or longitude format';
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 10, 12, 31),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 2,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color.fromARGB(255, 24, 28, 46),
                      ),
                    )
                  : Text('Set Angle',
                      style: TextStyle(fontSize: 18, color: Colors.indigo[700])),
            ),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (_compassDirection == null) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 24),
                          Text('Waiting for compass data...'),
                        ],
                      ),
                    );
                  }

                  // Corrected Angle Calculation
                  double diff = (_qiblaDirection ?? 0) - (_compassDirection ?? 0);
                  if (diff < 0) diff += 360;
                  double angleDifference = diff * (pi / 180);

                  double compassRad = (_compassDirection ?? 0) * (pi / 180);

                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer circle
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[300]!, width: 2),
                          ),
                        ),

                        // Compass directions (rotating with compass)
                        Transform.rotate(
                          angle: compassRad,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(top: 0, child: _buildDirectionText("N", 32)),
                              Positioned(bottom: 0, child: _buildDirectionText("S", 32)),
                              Positioned(left: 0, child: _buildDirectionText("W", 32)),
                              Positioned(right: 0, child: _buildDirectionText("E", 32)),
                              Positioned(top: 40, left: 40, child: _buildDirectionText("NW", 18)),
                              Positioned(top: 40, right: 40, child: _buildDirectionText("NE", 18)),
                              Positioned(bottom: 40, left: 40, child: _buildDirectionText("SW", 18)),
                              Positioned(bottom: 40, right: 40, child: _buildDirectionText("SE", 18)),
                            ],
                          ),
                        ),

                        // Inner circle
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                        ),

                        // Qibla direction indicator (green arrow)
                        if (_qiblaDirection != null)
                          Transform.rotate(
                            angle: angleDifference,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 60,
                                  child: ClipPath(
                                    clipper: TriangleClipper(),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Compass needle (red arrow - always points north)
                        Transform.rotate(
                          angle: compassRad,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 60,
                                child: ClipPath(
                                  clipper: TriangleClipper(),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Center dot
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: AppColors.darkBackground,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Qibla Direction: ${_qiblaDirection?.toStringAsFixed(1) ?? "Not set"}°',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Current Heading: ${_compassDirection?.toStringAsFixed(1)}°',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_latitudeCont.text.isNotEmpty && _longitudeCont.text.isNotEmpty) {
                        try {
                          double lat = double.parse(_latitudeCont.text);
                          double lng = double.parse(_longitudeCont.text);
                          context.read<QiblaCubit>().getQibla(lat, lng);
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Invalid latitude or longitude format';
                          });
                        }
                      } else {
                        setState(() {
                          _errorMessage = 'Please enter both latitude and longitude';
                        });
                      }
                    },
                    icon: const Icon(Icons.refresh, size: 28),
                    tooltip: 'Refresh Qibla Direction',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionText(String direction, double fontSize) {
    return Text(
      direction,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  void _listenToCompass() {
    _compassSubscription = FlutterCompass.events?.listen((event) {
      setState(() {
        _compassDirection = event.heading;
      });
    });
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
