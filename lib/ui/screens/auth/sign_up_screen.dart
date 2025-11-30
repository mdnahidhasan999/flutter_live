import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/network-response.dart';
import 'package:flutter_live/ui/utility/app_constants.dart';
import 'package:flutter_live/ui/widgets/snackbar_message.dart';

import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
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

                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(hintText: 'Email'),
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
                      controller: _firstNameController,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,

                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),

                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: 'Mobile Number'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your mobile number';
                        }
                        if (!AppConstants.mobileRegex.hasMatch(value!)) {
                          return 'Please enter a valid Bangladeshi number';
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
                      replacement: Center(child: CircularProgressIndicator()),

                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (!_isLoading) {
                              _registerUser();
                            }
                          }
                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 22,
                        ),
                      ),
                    ),

                    SizedBox(height: 36),
                    _buildSignInBtn(),
                  ],
                ),
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

  void _registerUser() async {
    _isLoading = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestInput = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
      "photo": "",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registration,
      body: requestInput,
    );
    if (mounted) {
      _isLoading = false;
      setState(() {});
    }
    if (response.isSuccess) {
      _clearTextField();
      if (mounted) {
        showSnackBarMessage(context, 'Registration Successful');
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Registration Failed',
          true,
        );
      }
    }
  }

  void _clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
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
