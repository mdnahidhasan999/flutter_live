import 'package:flutter/material.dart';
import 'package:flutter_live/ui/controllers/auth_controller.dart';

import '../screens/auth/sign_in_screen.dart';
import '../screens/update_profile_screen.dart';
import '../utility/app_colors.dart';
import 'network_cached_image.dart';

AppBar profileAppBar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,

          child: NetworkCachedImage(
            imageUrl: 'https://www.w3schools.com/howto/img_avatar.png',
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(
            AuthController.userData?.fullName ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            AuthController.userData?.email ?? '',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          AuthController.clearAuthData();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false,
          );
        },
        icon: Icon(Icons.logout, color: Colors.white),
      ),
    ],
  );
}
