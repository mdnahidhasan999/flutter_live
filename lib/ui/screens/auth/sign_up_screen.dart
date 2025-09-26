import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';
import '../../widgets/background_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

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
                  SizedBox(height: 50),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),

                  SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameController,

                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  SizedBox(height: 8),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Mobile Number'),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.arrow_circle_right_outlined, size: 22),
                  ),

                  SizedBox(height: 36),
                  _buildSignInBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
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
                      _onTapSingIn();
                    },
            ),
          ],
        ),
      ),
    );
  }

  void _onTapSingIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();

    super.dispose();
  }
}

//30
