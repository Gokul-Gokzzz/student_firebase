import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/controller/add_screen_provider.dart';
import 'package:firebase_crud/controller/edit_screen_provider.dart';
import 'package:firebase_crud/controller/student_provider.dart';
import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/model/firebase_options.dart';

import 'package:firebase_crud/view/home_screen/home.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ImageProviderr(),
        ),
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
