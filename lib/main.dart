import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/logout_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/clinical/clinical_historic_screen.dart';
import 'screens/clinical/create_historic_screen.dart';
import 'screens/doc/justifications/create_justifications_screen.dart';
import 'screens/doc/justifications/list_justifications_screen.dart';
import 'screens/doc/requisitions/create_justifications_screen.dart';
import 'screens/doc/requisitions/list_requisition_screen.dart';
import 'screens/home_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/maps/map_screen.dart';
import 'screens/occurrence/occurrences_create_screen.dart';
import 'screens/occurrence/occurrences_edit_screen.dart';
import 'screens/occurrence/occurrences_list_screen.dart';
import 'screens/occurrence/occurrences_view_screen.dart';
import 'screens/reports/reports_list_screen.dart';

import 'screens/settings/settings_edit_screen.dart';
import 'screens/settings/settings_view_screen.dart';
import 'screens/simple_screen.dart';
import 'screens/users/users_list_screen.dart';
import 'screens/users/users_register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Sistema VS Global',
      theme: ThemeData(
        fontFamily: 'Worksans',
      ),
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => const LoadingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        LogoutScreen.id: (context) => const LogoutScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ListOccourenceScreen.id: (context) => const ListOccourenceScreen(),
        CreateOccourenceScreen.id: (context) => const CreateOccourenceScreen(),
        EditOccourenceScreen.id: (context) => const EditOccourenceScreen(),
        ViewOccourenceScreen.id: (context) => const ViewOccourenceScreen(),
        ListUsersScreen.id: (context) => const ListUsersScreen(),
        UserRegisterScreen.id: (context) => const UserRegisterScreen(),
        EditSettingScreen.id: (context) => const EditSettingScreen(),
        ViewSettingScreen.id: (context) => const ViewSettingScreen(),
        ListReportScreen.id: (context) => const ListReportScreen(),
        //
        ListJustificationScreen.id: (context) =>
            const ListJustificationScreen(),
        CreateJustificationScreen.id: (context) =>
            const CreateJustificationScreen(),
        //
        ListRequisitiomScreen.id: (context) => const ListRequisitiomScreen(),
        CreateRequisitiomScreen.id: (context) =>
            const CreateRequisitiomScreen(),
        //
        ClinicalHistoricScreen.id: (context) => const ClinicalHistoricScreen(),
        CreateHistoricScreen.id: (context) => const CreateHistoricScreen(),

        MapScreen.id: (context) => const MapScreen(),
        //
        SimpleScreen.id: (context) => const SimpleScreen(),
      },
    );
  }
}
