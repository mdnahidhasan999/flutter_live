import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utility/app_colors.dart';
import '../widgets/background_widget.dart';
import 'reset_password_screen.dart';
import 'sign_in_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A 6 digit verification pin has been sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 24),

                  buildPinCodeTextField(),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _onTapVerifyOtpBtn();
                    },
                    child: Text('Verify'),
                  ),

                  SizedBox(height: 36),
                  buildSignInSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Have account? ",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: AppColors.themeColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      // Handle sign up tap
                      _onTapSignIn();
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
        activeColor: AppColors.themeColor,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      controller: _pinController,

      appContext: context,
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false,
    );
  }

  void _onTapVerifyOtpBtn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReserPasswordScreen()),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}

//55
