import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controller/logincontroller.dart';
import 'package:getxproject/controller/profilecontroller.dart';
import 'package:getxproject/login.dart';
import 'package:getxproject/profile.dart';
import 'package:getxproject/utils/my_session.dart';

Future<void> main() async {
  Get.put(LoginController());
  Get.put(Profilecontroller());
  await MySession.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var userId= '';

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  void getUserId() async{
    userId = await MySession.getUserId();
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: userId.isEmpty ?  LoginPage() : ProfilePage(),
    );
  }
}
