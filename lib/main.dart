import 'package:flutter/material.dart';
import 'package:movie_db/modules/user/add/add_screen.dart';
import 'package:movie_db/modules/user/detail/detail_user_screen.dart';
import 'package:movie_db/modules/user/detail/model/detail_user_response.dart';

import 'modules/user/list/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'FreeSans',
        primarySwatch: Colors.blue,
      ),
      home: UserScreen(),
      routes: {
        AddScreen.routeName: (context) => AddScreen(ModalRoute.of(context)!.settings.arguments as Data),
        DetailUserScreen.routeName: (context) => DetailUserScreen(ModalRoute.of(context)!.settings.arguments as int)
      },
    );
  }
}
