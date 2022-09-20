import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:systemglobalvc/models/booking_model.dart';

import '../../constant.dart';
import '../../models/api_response.dart';
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

  List<dynamic> _bookingList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> viewBooking() async {
    userId = await getUserId();
    ApiResponse response = await getBook(widget.bookID);

    if (response.error == null) {
      setState(() {
        _bookingList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text(
                        'Meus Agendamento',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: kColorPrimary,
                          minimumSize: const Size(
                            150,
                            50,
                          ),
                        ),
                        onPressed: () {
                          
                        },
                        child: const Text("CANCELAR"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _bookingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      BookingModel booking = _bookingList[index];
                      return ListTile(
                          onTap: () {
                        },
                        leading: booking.status == 1
                            ? SvgPicture.asset(
                                'assets/images/svg/livro-de-enderecos.svg',
                                width: 45,
                                height: 45,
                                color: kColorPrimaryLight,
                              )
                            : SvgPicture.asset(
                                'assets/images/svg/livro-de-enderecos.svg',
                                width: 45,
                                height: 45,
                                color: Colors.grey[400],
                              ),
                        title: Text('${booking.subject}'),
                        subtitle: Row(
                          children: [
                            Text('REF00${booking.id}'),
                            const SizedBox(width: 20),
                            Text('${booking.date}'),
                            const SizedBox(width: 20),
                            Text('${booking.user!.name}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
      
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
