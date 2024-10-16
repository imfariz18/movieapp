import 'package:flutter/material.dart';

import 'package:movieapp/root/routes/routes.dart';
import 'package:movieapp/searchbutton.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: routers.home,
      routes: {
        routers.home: (context) => Homepage(),
      },
    );
  }
}
