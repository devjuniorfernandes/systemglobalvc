import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../constant.dart';
import '../../models/api_response.dart';
import '../../services/auth_service.dart';
import '../../services/occorrences_service.dart';
import '../../widgets/boxUser_widget.dart';
import '../../widgets/circular_indicator_widget.dart';
import '../../widgets/sidebarmenu_widget.dart';
import '../auth/login_screen.dart';
import 'occurrences_list_screen.dart';

class CreateOccourenceScreen extends StatefulWidget {
  static const String id = 'createoccorrence-screen';
  const CreateOccourenceScreen({Key? key}) : super(key: key);

  @override
  State<CreateOccourenceScreen> createState() => _CreateOccourenceScreenState();
}

class _CreateOccourenceScreenState extends State<CreateOccourenceScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  bool loading = false;

  void _createOccorrence() async {
    ApiResponse response = await createOccorrence(
      _nameController.text,
      _addressController.text,
      _descriptionController.text,
      _idadeController.text,
      _numberPhoneController.text,
      _subjectController.text,
    );

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ListOccourenceScreen()),
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
        title: const Text('Adicionar de Occorrência'),
        backgroundColor: kColorPrimary,
        elevation: 0,
        actions: const [
          BoxUser(),
        ],
      ),
      sideBar: sideBar.sidebarMenus(context, ListOccourenceScreen.id),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Nome do Paciente",
                        label: Text("Nome do Paciente"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      controller: _idadeController,
                      decoration: const InputDecoration(
                        hintText: "Idade",
                        label: Text("Idade"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _numberPhoneController,
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Nº de Telefone",
                        label: Text("Nº de Telefone"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Endereço",
                        label: Text("Digite seu Endereço"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Dados da Ocorrência',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _subjectController,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Ocorrência",
                        label: Text("Ocorrência"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val!.isEmpty ? "Essa dado é obrigatório" : null,
                      decoration: const InputDecoration(
                        hintText: "Relato do Paciente",
                        label: Text("Relato do Paciente"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              _createOccorrence();
                            }
                          },
                          child: const Text("GRAVAR OCORRÊNCIA"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}