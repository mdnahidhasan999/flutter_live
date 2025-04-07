import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Live', home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        // child: Text(
        //   'Hello, Flutter!, Welcome to Flutter Live',
        //   textAlign: TextAlign.center,
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        //   style: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //     backgroundColor: Colors.purple,
        //   ),
        // ),
        // child: Icon(Icons.android, size: 84, color: Colors.white),
        child: Image.network('https://www.w3schools.com/howto/img_avatar.png',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          color: Colors.white,
          colorBlendMode: BlendMode.darken,
        ),

      ),
    );
  }
}

//47
