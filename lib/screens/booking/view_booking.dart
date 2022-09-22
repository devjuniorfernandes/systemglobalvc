import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:systemglobalvc/models/booking_model.dart';

import '../../constant.dart';
import '../../models/api_response.dart';
import '../../models/booking_model.dart';
import '../../services/auth_service.dart';
import '../../services/booking_service.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';

class ViewBooking extends StatefulWidget {
  static const String id = 'view-booking';

  final String bookID;
  const ViewBooking({required this.bookID});

  @override
  State<ViewBooking> createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBooking> {

  BookingModel? booking;
  bool _loading = true;

  // get all posts
  Future<void> viewBooking() async {
    ApiResponse response = await getBook(widget.bookID);

    if (response.error == null) {
      setState(() {
        booking = response.data as BookingModel;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    viewBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vizualizador'),
        backgroundColor: kColorPrimary,
        elevation: 0,
      ),
      sideBar: sideBar.sidebarMenus(context, ViewBooking.id),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
            children: [
              Text(booking!.id.toString()),
            ],
          )
          
          );
  }
}
