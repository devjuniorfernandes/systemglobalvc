// get user level
import 'package:shared_preferences/shared_preferences.dart';


// BOOKING

Future<int> getBookId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('bookingID') ?? 0;
}

Future<String> getbookingName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingName') ?? '';
}

Future<String> getbookingEmail() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingEmail') ?? '';
}

Future<String> getbookingDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingDate') ?? '';
}

Future<String> getbookingPassport() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingPassport') ?? '';
}

Future<String> getbookingPhone() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingPhone') ?? '';
}

Future<String> getbookingSubject() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingSubject') ?? '';
}

Future<String> getbookingDescription() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bookingDescription') ?? '';
}


/********************** DELET ALL **********/
// JUSTIFICATION

Future<String> getJustfName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfName') ?? '';
}

Future<String> getJustfSubject() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfSubject') ?? '';
}

Future<String> getJustfDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfDate') ?? '';
}

Future<int> getJustfID() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('justfID') ?? 0;
}

Future<String> getJustfBI() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfBI') ?? '';
}

Future<String> getJustfDays() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfDays') ?? '';
}

Future<String> getJustfAfter() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfAfter') ?? '';
}


// REQUISITIONS

Future<int> getRequisId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('requisId') ?? 0;
}

Future<String> getRequisName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisName') ?? '';
}

Future<String> getRequisAge() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisAge') ?? '';
}

Future<String> getRequisPreD() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisPrediagnosis') ?? '';
}

Future<String> getRequisExams() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisExames') ?? '';
}

Future<String> getRequisDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisDate') ?? '';
}
