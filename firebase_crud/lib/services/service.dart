// firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  String collectionRef = 'Student';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  late final CollectionReference<StudentModel> studentRef;

  FirebaseService() {
    studentRef =
        firestore.collection(collectionRef).withConverter<StudentModel>(
              fromFirestore: (snapshot, options) =>
                  StudentModel.fromJson(snapshot.data() ?? {}),
              toFirestore: (value, options) => value.toJson(),
            );
  }
}
