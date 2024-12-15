import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/controller/profilecontroller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  String? _selectedGender;

  final _genders = ['Male', 'Female', 'Other'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    Get.find<Profilecontroller>().fetchProfile();
    super.initState();
  }

  void setData(Profilecontroller profilecontroller){
    final profile = profilecontroller.profile.value.response!;
    _nameController.text = profile.fullName.toString();
    _emailController.text = profile.emailId.toString();
    _mobileController.text = profile.mobileNumber.toString();
    // _nameController.text = profile.fullName.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: GetBuilder<Profilecontroller>(builder: (profilecontroller) {
        if (profilecontroller.profile.value.response != null) {
          setData(profilecontroller);
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: _profileImage!=null? CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ): CircleAvatar(radius: 50, backgroundImage: NetworkImage(profilecontroller.profile.value.response?.profilePhoto.toString()??''),)
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    items: _genders
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: !profilecontroller.isLoading ?  ElevatedButton(
                      onPressed: () {
                        // Handle save action here
                        profilecontroller.updateProfile(_nameController.text.trim(), _mobileController.text.trim(), _emailController.text.trim(), 'male', _profileImage);
                      },
                      child: Text('Save Profile'),
                    ): CircularProgressIndicator()
                  ),
                ],
              ),
            ),
          );
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}
