import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/user_model.dart';
import 'package:flutter_live/data/utilities/urls.dart';
import 'package:flutter_live/ui/controllers/auth_controller.dart';
import 'package:flutter_live/ui/widgets/background_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/network-response.dart';
import '../../data/network_caller/network_caller.dart';
import '../widgets/profile_appbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.userData!.email ?? '';
    _firstNameController.text = AuthController.userData!.firstName ?? '';

    _lastNameController.text = AuthController.userData!.lastName ?? '';

    _mobileNumberController.text = AuthController.userData!.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: profileAppBar(context, true),
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 48),
                    Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 24),
                    _buildPhotoPickerWidget(),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      enabled: false,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: 'Mobile Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      //obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24),
                    Visibility(
                      visible: isLoading == false,
                      replacement: CircularProgressIndicator(),

                      child: ElevatedButton(
                        onPressed: () {
                          _updateProfile();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    isLoading = true;
    String encodePhoto = AuthController.userData!.photo ?? '';

    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      'email': _emailController.text,
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'mobile': _mobileNumberController.text.trim(),
    };
    if (_passwordController.text.isNotEmpty) {
      requestBody['password'] = _passwordController.text;
    }
    if (_image != null) {
      File file = File(_image!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodePhoto;
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.updateProfile,
      body: requestBody,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
        email: _emailController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileNumberController.text.trim(),
        photo: encodePhoto,
      );
      await AuthController.saveUserData(userModel);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Update successfully!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.errorMessage ?? 'Update failed!')),
        );
      }
    }

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _picProfilePhoto,
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 110,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: Text(
                ' Change Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                _image != null ? _image!.path : 'No image selected',
                maxLines: 1,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _picProfilePhoto() async {
    final imagePicker = ImagePicker();

    final XFile? result = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null) {
      setState(() {
        _image = result;
      });
    }
  }
}

//46-p-v
