import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../constant.dart';
import '../screens/auth/logout_screen.dart';
import '../screens/clinical/create_historic_screen.dart';
import '../screens/home_screen.dart';

class SideBarWidget {
  var timeNow = DateTime.now();

  final List<AdminMenuItem> _sideBarItems = const [
    AdminMenuItem(
      title: 'Meus Pedidos',
      route: HomeScreen.id,
      icon: Icons.dashboard_outlined,
    ),
    AdminMenuItem(
      title: 'Outro Menu',
      route: CreateHistoricScreen.id,
      icon: Icons.history,
    ),
    AdminMenuItem(
      title: 'Terminar Sessão',
      route: LogoutScreen.id,
      icon: Icons.logout_outlined,
    ),
  ];

  sidebarMenus(context, selectedRout) {
    return SideBar(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      iconColor: kColorPrimary,
      activeIconColor: Colors.white,
      activeBackgroundColor: kColorPrimary,
      textStyle: const TextStyle(
        color: kColorPrimary,
        fontSize: 15,
      ),
      activeTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      items: _sideBarItems,
      selectedRoute: selectedRout,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 150,
        width: double.infinity,
        color: const Color.fromARGB(255, 233, 233, 233),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/images/logo.png'),
        )),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: const Color.fromARGB(255, 233, 233, 233),
        child: Center(
          child: Text(
            timeNow.toString(),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
