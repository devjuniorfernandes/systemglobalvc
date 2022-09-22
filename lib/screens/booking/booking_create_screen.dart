import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:systemglobalvc/screens/home_screen.dart';

import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../services/booking_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/circular_indicator_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';

class BookingCreateScreen extends StatefulWidget {
  static const String id = 'create-booking';
  const BookingCreateScreen({Key? key}) : super(key: key);

  @override
  State<BookingCreateScreen> createState() => _BookingCreateScreenState();
}

class _BookingCreateScreenState extends State<BookingCreateScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController passportController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateCOntroller = TextEditingController(text: DateTime.now().toString());

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Visto de Viagem", child: Text("Visto de Viagem")),
      const DropdownMenuItem(value: "Visto de Trabalho", child: Text("Visto de Trabalho")),
      const DropdownMenuItem(value: "Visto de Residente", child: Text("Visto de Residente")),
    ];
    return menuItems;
  }
  String? dropdownValue;
  bool loading = false;
  String? dateController;

  void _createBook() async {
    ApiResponse response = await createBooking(
      dateController!,
      passportController.text,
      numberController.text,
      dropdownValue!,
      descriptionController.text,
    );

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } else if (response == unauthorized) {
      logout().then((value) => [
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          ]);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = !loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Novo Agendamento'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, HomeScreen.id),
      body: loading
          ? const Center(child: MyCircularIndicator())
          : Form(
              key: formkey,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Adicionar Nova Ocorrência',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Dados Pessoais',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: DateTimePicker(
                        locale: const Locale("pt", "BR"),
                        type: DateTimePickerType.dateTime,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2023),
                        initialTime: TimeOfDay.now(),
                        use24HourFormat: true,
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Data',
                        timeLabelText: "Hora",
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }
                          return true;
                        },
                        onChanged: (val) {
                          setState(() {
                            dateController = val;
                          });
                        },
                        validator: (val) {
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            dateController = val;
                          });
                        }),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: DropdownButtonFormField(
                        hint: const Text('Selecione o Visto'),
                        value: dropdownValue,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: dropdownItems),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: passportController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Número de Passaporte",
                        label: Text("Digite Número de Passaporte"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Número de Telefone",
                        label: Text("Digite Número de Telefone"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Descrição do Agendamento",
                        label: Text("Digite uma pequena descrição"),
                      ),
                    ),
                  ),
                   const SizedBox(height: 30),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            loading = !loading;
                            _createBook();
                          });
                        } 
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kColorPrimary),
                          padding: MaterialStateProperty.resolveWith((states) =>
                              const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15))),
                      child: const Text(
                        "AGENDAR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ),
                ],
              ),
            ),
    );
  }
}
