import 'package:flutter/material.dart';
import 'package:flutter_live/ui/utility/asset_paths.dart';
import 'package:flutter_live/ui/widgets/background_widget.dart';
import 'package:flutter_svg/svg.dart';

import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(child: SvgPicture.asset(AssetPaths.logoSvg, width: 140)),
      ),
    );
  }
}
