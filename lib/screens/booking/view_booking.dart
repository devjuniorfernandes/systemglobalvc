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
          title: const Text('Detalhes'),
          backgroundColor: kColorPrimary,
          elevation: 0,
        ),
        sideBar: sideBar.sidebarMenus(context, ViewBooking.id),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Text(
                      "AGENDAMENTO REF0${booking!.id}",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "ESTADO DO AGENDAMENTO",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(width: 20),
                        booking!.status != 1 ? TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kColorPrimaryLight),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15))),
                          child: const Text(
                            "ATIVO",
                            style: TextStyle(color: Colors.white),
                          ),
                        ) : TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kColorRedLight),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15))),
                          child: const Text(
                            "CANCELADO",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Nome:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.user!.name}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("E-mail:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.user!.email}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Telefone:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.phone_number}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Nº do Passaporte:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.passport_number}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Data do Agendamento:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.date}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Tipo de Visto:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.subject}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Text("Taxa a Pagar:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        SizedBox(width: 10),
                        Text(
                          "15.000,00",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Descrição:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        const SizedBox(width: 10),
                        Text(
                          "${booking!.description}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kColorPrimary),
                            padding: MaterialStateProperty.resolveWith(
                                (states) => const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15))),
                        child: const Text(
                          "CONFIRMAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kColorRed),
                            padding: MaterialStateProperty.resolveWith(
                                (states) => const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15))),
                        child: const Text(
                          "CANCELAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
