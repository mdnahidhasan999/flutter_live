import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/ui/screens/auth/email_verification_screen.dart';
import 'package:flutter_live/ui/screens/auth/sign_up_screen.dart';
import '../../../data/models/login_model.dart';
import '../../../data/models/network-response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../controllers/auth_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_constants.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/snackbar_message.dart';
import '../main_bottom_nav_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Get Started with',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 24),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(hintText: 'Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (AppConstants.emailRegex.hasMatch(value!) == false) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,

                      obscureText: _isObscure == false,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }
                          },
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Visibility(
                      visible: _isLoading == false,
                      replacement: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.themeColor,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapNextBtn();
                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 22,
                        ),
                      ),
                    ),

                    SizedBox(height: 36),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPass,
                            child: Text('Forgot Password?'),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          // Handle sign up tap
                                          _onTapSignUp();
                                        },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextBtn() {
    // Handle sign in logic here
    if (_formKey.currentState!.validate()) {
      if (!_isLoading) {
        _signUp();
      }
    }
  }

  Future<void> _signUp() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestInput = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.login,
      body: requestInput,
    );
    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Login failed, try again',
        );
      }
    }
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void _onTapForgotPass() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

//55
