import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:systemglobalvc/models/booking_model.dart';
import 'package:systemglobalvc/screens/booking/booking_create_screen.dart';
import 'package:systemglobalvc/screens/booking/view_booking.dart';
import '../constant.dart';
import '../models/api_response.dart';
import '../services/auth_service.dart';
import '../services/booking_service.dart';
import '../widgets/boxUser_widget.dart';
import '../widgets/sidebarmenu_widget.dart';
import 'auth/login_screen.dart';
import 'pdfs/booking/booking_pdf.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _bookingList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> gettingBookings() async {
    userId = await getUserId();
    ApiResponse response = await getBookings();

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

  void _getDocBooking(BookingModel booking) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('bookingID', booking.id ?? 0);
    await pref.setString('bookingName', booking.user!.name ?? '');
    await pref.setString('bookingEmail', booking.user!.email ?? '');
    await pref.setString('bookingDate', booking.date ?? '');
    await pref.setString('bookingPassport', booking.passport_number ?? '');
    await pref.setString('bookingPhone', booking.phone_number ?? '');
    await pref.setString('bookingSubject', booking.subject ?? '');
    await pref.setString('bookingDescription', booking.description ?? '');

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingPDF()),
    );
  }

  @override
  void initState() {
    gettingBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pagina Inicial'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, HomeScreen.id),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookingCreateScreen(),
                            ),
                          );
                        },
                        child: const Text("NOVO"),
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
                          _getDocBooking(booking);
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
                        title: Text('REF00${booking.id}'),
                        subtitle: Row(
                          children: [
                            Text('${booking.date}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.view_agenda),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewBooking(
                                      bookID: booking.id.toString())),
                            );
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
