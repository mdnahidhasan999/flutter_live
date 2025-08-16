import 'package:flutter/material.dart';

// void main() {
//   runApp(iOSStyleApp());
// }
//
// class iOSStyleApp extends StatelessWidget {
//   const iOSStyleApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoApp(home: HomePage());
//   }
// }
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('Home'),
//         trailing: Icon(CupertinoIcons.add),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CupertinoActivityIndicator(radius: 25),
//             CupertinoSwitch(value: false, onChanged: (value) {}),
//           ],
//         ),
//       ),
//     );
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: HomeScreen(),
    theme: ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      )

    ),);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Tap to edit')),
            TextButton(onPressed: () {}, child: Text('Tap to edit')),
            TextField(),
          ],
        ),
      ),
    );
  }
}
//cl-9-p3live23m