import 'package:flutter/material.dart';

import 'package:movieapp/root/routes/root.dart';
import 'package:movieapp/searchbutton.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create:(context) => MovieProvider(),)
    ],
    child: const Root()));
}