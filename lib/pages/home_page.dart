import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0052CC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0052CC),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0052CC)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DIMAANO’S DENTAL CLINIC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              title: const Text('Schedule Appointment'),
              onTap: () => Navigator.pushNamed(context, '/schedule'),
            ),
            ListTile(
              title: const Text('View My Appointments'),
              onTap: () => Navigator.pushNamed(context, '/myAppointment'),
            ),
            ListTile(
              title: const Text('Personal Details'),
              onTap: () => Navigator.pushNamed(context, '/personalDetails'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052CC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xFF0052CC)),
                    ),
                  ),
                  child: const Text('Log out'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Top section: logo only
          Container(
            padding: const EdgeInsets.only(top: 60),
            color: const Color(0xFF0052CC),
            child: Column(
              children: [
                Image.asset(
                  'assets/tooth.png', // Replace with your image path
                  height: 140,
                  color: Colors.white,
                ),
                const SizedBox(height: 80), // spacing below logo
              ],
            ),
          ),
          // White curved section
          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _navButton(
                      context, 'SCHEDULE AN APPOINTMENT', '/schedule'),
                  const SizedBox(height: 20),
                  _navButton(
                      context, 'VIEW PERSONAL DETAILS', '/personalDetails'),
                  const SizedBox(height: 20),
                  _navButton(context, 'VIEW MY APPOINTMENT', '/myAppointment'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String text, String route) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0052CC),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
