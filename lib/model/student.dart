import 'package:cloud_firestore/cloud_firestore.dart';
class Student {
  String fname;
  String lname;
  String email;
  String score;

  Student({
    required this.fname,
    required this.lname,
    required this.email,
    required this.score,
  });

  // แปลงข้อมูลจาก Firestore Document ให้เป็น Object ของ Student
  factory Student.fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return Student(
      fname: data['fname'] ?? '',
      lname: data['lname'] ?? '',
      email: data['email'] ?? '',
      score: data['score'] ?? '',
    );
  }
}
