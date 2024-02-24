import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier {
  TextEditingController rollnoController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController imageController = TextEditingController();
}
