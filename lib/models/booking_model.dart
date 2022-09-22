
import 'user_model.dart';

class BookingModel {
  int? id;
  String? date;
  int? userid;
  String? passport_number;
  String? phone_number;
  String? subject;
  String? description;
  int? status;
  User? user;

  BookingModel(
      {this.id,
      this.user,
      this.date,
      this.passport_number,
      this.phone_number,
      this.subject,
      this.description,
      this.status,
      this.userid,
    });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userid: json['user_id'],
      date: json['date'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
      ),
      passport_number: json['passport_number'],
      phone_number: json['phone_number'],
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
    );
  }
}