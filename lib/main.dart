import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:systemglobalvc/screens/booking/booking_create_screen.dart';
import 'package:systemglobalvc/screens/qr_scan/qrscan_screen.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/logout_screen.dart';
import 'screens/auth/register_screen.dart';

import 'screens/booking/view_booking.dart';
import 'screens/home_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/simple_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],

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
        BookingCreateScreen.id: (context) => const BookingCreateScreen(),
        ViewBooking.id: (context) => const ViewBooking(bookID: '',),
        //
        QrScanScreen.id: (context) =>  QrScanScreen(),
        SimpleScreen.id: (context) => const SimpleScreen(),
      },
    );
  }
}
