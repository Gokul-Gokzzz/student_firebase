import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/model.dart';
import 'package:firebase_crud/services/service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  FirebaseService _firebaseService = FirebaseService();
  String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = '';
  File? selectedImage;

  Stream<QuerySnapshot<StudentModel>> getData() {
    return _firebaseService.studentRef.snapshots();
  }

  void addStudent(StudentModel student) async {
    await _firebaseService.studentRef.add(student);
    notifyListeners();
  }

  void deleteStudent(String id) async {
    await _firebaseService.studentRef.doc(id).delete();
    notifyListeners();
  }

  void updateStudent(String id, StudentModel student) async {
    await _firebaseService.studentRef.doc(id).update(student.toJson());
    notifyListeners();
  }

  imageAdder(image) async {
    //for the image saving path  .ref().child('images'); refrence and the folder name image
    Reference folder = _firebaseService.storage.ref().child('images');
    Reference images = folder.child("$uniquename.jpg");
    try {
      await images.putFile(image);
      downloadurl = await images.getDownloadURL();
      notifyListeners();
      // ignore: avoid_print
      print(downloadurl);
    } catch (e) {
      throw Exception(e);
    }
  }

  void addstudent(BuildContext context) async {
    // final studentProvider =
    //     Provider.of<StudentProvider>(context, listen: false);
    // final imgProvider = Provider.of<ImageProviderr>(context, listen: false);
    // final addProvider = Provider.of<AddProvider>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final rollno = rollnoController;

    await imageAdder(File(selectedImage!.path));

    final student = StudentModel(
      rollno: rollno.text,
      age: age,
      name: name,
      image: downloadurl,
    );
    addStudent(student);
  }
}
