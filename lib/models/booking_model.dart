
import 'user_model.dart';

class BookingModel {
  int? id;
  User? user;
  String? date;
  String? passport_number;
  String? phone_number;
  String? subject;
  String? description;
  int? status;

  BookingModel(
      {this.id,
      this.user,
      this.date,
      this.passport_number,
      this.phone_number,
      this.subject,
      this.description,
      this.status,
    });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
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