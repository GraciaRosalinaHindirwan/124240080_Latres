import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latres/models/user_model.dart';
import 'package:latres/pages/home_page.dart';
import 'package:latres/pages/register_page.dart';
import 'package:latres/pages/login_page.dart';

void main() async{
  //inisialisasi hive 
  WidgetsFlutterBinding.ensureInitialized(); //pastiin flutter ready
  await Hive.initFlutter(); // inisialisasi HIVE
  Hive.registerAdapter(UserModelAdapter()); //daftar adapter userModel

  await Hive.openBox<UserModel>('users'); // buka box 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      
    );
  }
}
