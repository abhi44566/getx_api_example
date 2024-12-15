import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/profile.dart';

import 'app_color.dart';


class OtpScreen extends StatefulWidget {
  final String otp;
  const OtpScreen({super.key, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // controller.startTimer();
  }

  @override
  void dispose() {
    // controller.timer!.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            ClipPath(
              clipper: OptClip(),
              child: Container(
                height: height * 0.35,
                color: AppColor.appColor,
              ),
            ),
            Positioned(
                bottom: height * 0.05,
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      // Image.asset(
                      //   AppImage.otp,
                      //   height: height * 0.25,
                      //   width: width * 0.9,
                      // ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Card(
                          child: Padding(
                            padding: EdgeInsets.all(
                            10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.04, bottom: height * 0.015),
                                  child: Text("OTP HERE"),
                                ),
                                TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  onChanged: (value) {
                                    if(widget.otp== value){
                                      Get.to(()=>ProfilePage());
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                        ElevatedButton(
                          onPressed: () {
                          Get.snackbar("Error"," Please enter otp");

                          },
                          child: const Text('Login'),

                        )],
                            ),
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class OptClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(w - 50, h * 0.8, w, h * 0.5);

    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}