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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                padding: EdgeInsets.all(24),
              ),
              onPressed: () {
                print('Elevated Button Clicked');
              },
              child: Text('Elevated Button'),
            ),
            SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueGrey,
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              onPressed: () {},
              child: Text('Text Button'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                maxLength: 10,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Text',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  label: Text('Label'),
                  //labelText: 'Email',
                  //   focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(2),
                  //     borderSide: BorderSide(width: 50, color: Colors.white),
                  //   )
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//41
