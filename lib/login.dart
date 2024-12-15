import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controller/logincontroller.dart';
import 'package:getxproject/profile.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            const SizedBox(height: 24.0),
            GetBuilder<LoginController>(
              builder: (loginController) {
                return !loginController.isLoading ? ElevatedButton(
                  onPressed: () {
                    String mobile = mobileController.text.toString().trim();
                    // Perform login logic here
                    // if (mobile.isEmpty || password.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Please fill in all fields.')),
                    //   );
                    // } else {
                    //   Get.to(()=>ProfilePage());
                    //   // Placeholder logic for demonstration
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Login successful for $mobile')),
                    //   );
                    // }
                    loginController.fetchLogin(mobile);

                  },
                  child: const Text('Login'),
                ) :  CircularProgressIndicator();
              }
            ),
          ],
        ),
      ),
    );
  }
}