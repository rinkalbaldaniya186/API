import 'package:api/Api1/models/playlist_provider.dart';
import 'package:api/Api1/pages/home_page.dart';
import 'package:api/Api1/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/dark_mode.dart';
import '../themes/light_mode.dart';

void main(){
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => ThemeProvider(),
    //   child: const MyApp(),
    // )
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider(),),
          ChangeNotifierProvider(create: (context) => PlayListProvider(),)
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
     bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const HomePage(),
     //  theme: Provider.of<ThemeProvider>(context, listen: false).themeData,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: lightMode,    // Default theme
      darkTheme: darkMode, // Dark theme
    );
  }
}
