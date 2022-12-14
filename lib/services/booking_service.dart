// get all Bookings
import 'dart:convert';

import 'package:systemglobalvc/models/booking_model.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/booking_model.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

// get all Bookings
Future<ApiResponse> getBookings() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse("$baseURL/booking"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['bookings']
            .map((o) => BookingModel.fromJson(o))
            .toList();
        // we get list of Bookings, so we need to map each item to post model
        apiResponse.data as List<dynamic>;

        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// CREATE Booking
// Future<ApiResponse> createPost(String body, String? image) async {

Future<ApiResponse> createBooking(
  String dateController,
  String passportController,
  String numberController,
  String subjectController,
  String descriptionController,
) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse("$baseURL/booking"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'date': dateController,
      'passport_number': passportController,
      'phone_number': numberController,
      'description': descriptionController,
      'subject': subjectController,
    });

    // here if the image is null we just send the body, if not null we send the image too

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Getting post
Future<ApiResponse> getBook(String bookID) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$baseURL/booking/$bookID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            BookingModel.fromJson(jsonDecode(response.body)['booking']);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> confirmBooking(
  int bookID,
) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.put(Uri.parse('$baseURL/booking/$bookID'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'status': 1,
    });

    // here if the image is null we just send the body, if not null we send the image too

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> notConfirmBooking(
  int bookID,
) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.put(Uri.parse('$baseURL/booking/$bookID'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'status': 0,
    });

    // here if the image is null we just send the body, if not null we send the image too

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Getting post
Future<ApiResponse> deleteBook(String bookID) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$baseURL/booking/$bookID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Delete post
Future<ApiResponse> deleteBookings(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$baseURL/booking/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
