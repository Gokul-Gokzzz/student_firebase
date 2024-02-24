import 'dart:io';
import 'package:firebase_crud/controller/add_screen_provider.dart';
import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/controller/student_provider.dart';
import 'package:firebase_crud/model/model.dart';
import 'package:firebase_crud/view/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddScreen extends StatelessWidget {
  AddScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imgProvider = Provider.of<ImageProviderr>(context);
    final addProvider = Provider.of<AddProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: addProvider.namecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addProvider.agecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Class',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: addProvider.rollnocontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Roll no',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        imgProvider.setImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                    ),
                    const SizedBox(
                      width: 14.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        imgProvider.setImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('From Gallery'),
                    ),
                  ],
                ),
                if (imgProvider.selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        imgProvider.selectedImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    addstudent(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addstudent(BuildContext context) async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final imgProvider = Provider.of<ImageProviderr>(context, listen: false);
    final addProvider = Provider.of<AddProvider>(context, listen: false);
    final name = addProvider.namecontroller.text;
    final age = addProvider.agecontroller.text;
    final rollno = addProvider.rollnocontroller;

    await studentProvider.imageAdder(File(imgProvider.selectedImage!.path));

    final student = StudentModel(
      rollno: rollno.text,
      age: age,
      name: name,
      image: studentProvider.downloadurl,
    );
    studentProvider.addStudent(student);
  }
}
