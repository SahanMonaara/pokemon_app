import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/screens/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

import '../common/app_assets.dart';
import '../common/app_colors.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  /// It fetches the data from the API and stores it in the provider.
  getInitialData() async {
    await Provider.of<PokemonProvider>(context, listen: false).getPokemonList();
    startTimer();
  }

  /// It starts a timer that will call the navigateToHome() function after 2
  /// seconds.
  void startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      navigateToHome();
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  /// It navigates to the LaunchesListScreen and removes all the previous screens
  /// from the stack.
  void navigateToHome() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(PokemonListScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  AppAssets.logo,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: SpinKitRipple(
                  color: AppColors.shadowColor,
                  size: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
