import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/home_page.dart';
import 'pages/schedule_page.dart';
import 'pages/confirm_schedule_page.dart';
import 'pages/schedule_success_page.dart';
import 'pages/my_appointment_page.dart';
import 'pages/personal_details_page.dart';
import 'pages/cancel_appointment_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DimaanosDentalApp());
}

class DimaanosDentalApp extends StatelessWidget {
  const DimaanosDentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dimaano’s Dental Clinic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0052CC),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/forgot': (context) => ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
        '/schedule': (context) => const SchedulePage(),
        '/confirm': (context) => const ConfirmSchedulePage(),
        '/success': (context) => const ScheduleSuccessPage(),
        '/myAppointment': (context) => const MyAppointmentPage(),
        '/personalDetails': (context) => const PersonalDetailsPage(),
        '/cancel': (context) => const CancelAppointmentPage(),
      },
    );
  }
}
