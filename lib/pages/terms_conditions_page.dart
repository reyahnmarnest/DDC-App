import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C), // Dark blue-black background
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        backgroundColor: const Color(0xFF0052CC), // Clinic Blue
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Dimaano's Dental Clinic!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "By creating an account and using this app, you agree to the following Terms and Conditions.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                Divider(color: Colors.white24),
                _Section(
                  title: "1. Information Collection",
                  content:
                      "We collect personal information such as name, email, phone number, and appointment details to provide our services effectively.",
                ),
                _Section(
                  title: "2. Data Usage",
                  content:
                      "Your information will only be used for managing your appointments, improving our services, and communicating important updates.",
                ),
                _Section(
                  title: "3. Data Privacy",
                  content:
                      "We value your privacy. All personal data is securely stored and will never be shared with third parties without your consent.",
                ),
                _Section(
                  title: "4. Account Responsibility",
                  content:
                      "You are responsible for maintaining the confidentiality of your account information.",
                ),
                _Section(
                  title: "5. Changes to Terms",
                  content:
                      "We may update these Terms and Conditions from time to time. We will notify you of any significant changes.",
                ),
                SizedBox(height: 24),
                Divider(color: Colors.white24),
                Text(
                  "If you have any questions or concerns regarding your data, feel free to contact our clinic directly.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0052CC), 
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
