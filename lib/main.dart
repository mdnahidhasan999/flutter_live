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
  Home({super.key});

  List<String> studentList = [
    'Nahid',
    'Sakib',
    'Shakib',
    'Sakib Al Hasan',
    'Sakib Al Hasan 2',

    'Sakib Al Hasan 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //       Text('Hello World'),
      //     ],
      //   ),
      // ),
      // body: ListView(
      //   children: [
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //     Text('Hello World'),
      //   ],
      // ),
      // body: ListView.builder(
      //   itemCount: 100,
      //   itemBuilder: (context, index) {
      //     return Text('${index + 1}', style: TextStyle(fontSize: 32));
      //   },
      // ),
      // body: ListView.builder(
      //   itemCount: studentList.length,
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         children: [
      //           Text(studentList[index],
      //           style: TextStyle(
      //             fontSize: 18
      //           ),),
      //           Divider(),
      //         ],
      //       ),
      //
      //     );
      //   },
      // ),
      body: ListView.separated(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(studentList[index], style: TextStyle(fontSize: 18)),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.white, thickness: 2, height: 20,
          endIndent: 16,
          indent: 16);
        },
      ),
    );
  }
}

//47
