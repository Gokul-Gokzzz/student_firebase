// ignore_for_file: avoid_print

import 'package:firebase_crud/controller/edit_screen_provider.dart';
import 'package:firebase_crud/controller/student_provider.dart';
import 'package:firebase_crud/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  StudentModel student;
  String id;
  EditScreen({super.key, required this.id, required this.student});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    super.initState();

    editProvider.nameController.text = widget.student.name ?? '';
    editProvider.ageController.text = widget.student.age ?? '';
    editProvider.rollnoController.text = widget.student.rollno ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                child: IconButton(
                    onPressed: () {
                      _showImageOptions(context);
                    },
                    icon: const Icon(Icons.camera)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: editProvider.nameController,
                  decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: editProvider.ageController,
                  decoration: InputDecoration(
                      hintText: "class",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: editProvider.rollnoController,
                  decoration: InputDecoration(
                      hintText: "rollno",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  onPressed: () {
                    editStudent(context);
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  editStudent(
    BuildContext context,
  ) async {
    final pro = Provider.of<StudentProvider>(context, listen: false);
    final editProvider = Provider.of<EditProvider>(context, listen: false);

    try {
      final editedname = editProvider.nameController.text;
      final editedrollno = editProvider.rollnoController.text;
      final editedage = editProvider.ageController.text;
      final editedimage = editProvider.imageController.text;

      // Update image URL in Firestore

      final updatedstudent = StudentModel(
        name: editedname,
        rollno: editedrollno,
        age: editedage,
        image: editedimage,
      );

      // Update student information in Firestore
      pro.updateStudent(widget.id, updatedstudent);

      Navigator.pop(context);
    } catch (e) {
      // Handle exceptions appropriately (e.g., show an error message)
      print("Error updating student: $e");
    }
  }

  Future<void> _showImageOptions(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          actions: [
            TextButton(
              onPressed: () async {},
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () async {},
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }
}
