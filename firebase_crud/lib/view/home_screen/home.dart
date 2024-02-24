// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/controller/student_provider.dart';
import 'package:firebase_crud/model/model.dart';
import 'package:firebase_crud/view/add_screen/add.dart';
import 'package:firebase_crud/view/detaile_screen/detaile_screen.dart';
import 'package:firebase_crud/view/edit_screen/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Student Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: Consumer<StudentProvider>(
            builder: (context, value, child) => Column(
              children: [
                StreamBuilder<QuerySnapshot<StudentModel>>(
                  stream: value.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Snapshot has error'),
                      );
                    } else {
                      List<QueryDocumentSnapshot<StudentModel>> studentsDoc =
                          snapshot.data?.docs ?? [];
                      return Expanded(
                        child: ListView.builder(
                          itemCount: studentsDoc.length,
                          itemBuilder: (context, index) {
                            final data = studentsDoc[index].data();
                            final id = studentsDoc[index].id;
                            return Card(
                              elevation:
                                  5, // Add elevation for a card-like look
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(
                                  data.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "class: ${data.rollno ?? 'N/A'}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "roll no: ${data.age ?? 'N/A'}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  backgroundImage: NetworkImage(data.image!),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        value.updateStudent(
                                            id,
                                            StudentModel(
                                                image: '',
                                                age: '',
                                                name: '',
                                                rollno: ''));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditScreen(
                                              id: id,
                                              student: data,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        value.deleteStudent(id);
                                        // value.deleteImage(data.image);
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(student: data),
                                              ));
                                        },
                                        icon:
                                            const Icon(Icons.arrow_forward_ios))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
        ),
        child: const Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
