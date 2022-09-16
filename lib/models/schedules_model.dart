import 'user_model.dart';

class SchedulesModel {
  int? id;
  User? user;
  String? dateSchedules;
  String? namePatients;
  String? passport_number;
  String? addressPatients;
  String? subject;
  String? description;
  int? status;

  SchedulesModel({
    this.id,
    this.user,
    this.dateSchedules,
    this.namePatients,
    this.addressPatients,
    this.subject,
    this.description,
    this.status,
  });

    factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      id: json['id'],
      dateSchedules: json['date_schedules'],
      namePatients: json['name_patients'],
      addressPatients: json['address_patients'],
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
      ),
      
    );
  }


}