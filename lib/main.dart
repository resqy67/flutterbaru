import 'package:flutter/material.dart';
import 'package:maskara/views/home.dart';
import 'package:maskara/views/widget/Artikel/artikelPage.dart';
import 'package:maskara/views/widget/Save/savePage.dart';
import 'package:flutter/services.dart';

void main() {
  // berikan potrait orientation only pada aplikasi
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maskara',
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
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
      // routes: {
      //   '/artikel': (context) => ArtikelPage(),
      //   '/bookmark': (context) => SavePage(),
      // },
    );
  }
}
