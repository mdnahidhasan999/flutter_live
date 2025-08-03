import 'package:flutter/cupertino.dart';

void main() {
  runApp(iOSStyleApp());
}

class iOSStyleApp extends StatelessWidget {
  const iOSStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home'),
        trailing: Icon(CupertinoIcons.add),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(radius: 25),
            CupertinoSwitch(value: false, onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
