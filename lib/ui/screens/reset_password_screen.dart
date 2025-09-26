import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/ui/screens/pin_verification_screen.dart';
import 'package:flutter_live/ui/screens/sign_in_screen.dart';

import '../utility/app_colors.dart';
import '../widgets/background_widget.dart';

class ReserPasswordScreen extends StatefulWidget {
  const ReserPasswordScreen({super.key});

  @override
  State<ReserPasswordScreen> createState() => _ReserPasswordScreenState();
}

class _ReserPasswordScreenState extends State<ReserPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                    'Set New Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Minimum length password 8 character with letters and numbers combination',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 24),

                  TextFormField(
                    controller: _passwordController,

                    decoration: InputDecoration(hintText: 'New Password'),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordController,

                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _onTapConfirmBtn();
                    },
                    child: Text('Confirm'),
                  ),

                  SizedBox(height: 36),
                  Center(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false,
    );
  }

  void _onTapConfirmBtn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

//55
