import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/ui/screens/pin_verification_screen.dart';

import '../utility/app_colors.dart';
import '../widgets/background_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A 6 digit verification pin will be sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 24),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(hintText: 'Email'),
                  ),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _onTapConfirmBtn();
                    },
                    child: Icon(Icons.arrow_circle_right_outlined, size: 22),
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
    Navigator.pop(context);
  }

  void _onTapConfirmBtn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PinVerificationScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

//55
