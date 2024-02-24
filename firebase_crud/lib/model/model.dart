class StudentModel {
  String? name;
  String? rollno;
  String? age;
  String? image;

  StudentModel({this.name, this.rollno, this.age, required this.image});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      image: json['image'],
      name: json['name'] as String?,
      rollno: json['rollno'] as String?,
      age: json['class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'rollno': rollno,
      'class': age,
    };
  }
}
