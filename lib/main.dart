import 'package:flutter/material.dart';
import 'package:flutter_shorts_internship_submission/provider/video_provider.dart';
import 'package:flutter_shorts_internship_submission/screens/selection_page.dart';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => VideoProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: SelectionScreen(),
      ),
    );
  }
}
