import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_widgets.dart';
import '../constants/constants.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool isEditing = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        final data = doc.data();
        nameController.text = data?['name'] ?? '';
        emailController.text = data?['email'] ?? '';
        phoneController.text = data?['phone'] ?? '';
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void saveDetails() async {
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details updated successfully')),
      );
      setState(() {
        isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Text('Personal Details'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 70, color: Colors.blue),
                  ),
                  const SizedBox(height: 30),

                  // Name
                  isEditing
                      ? CustomInputField(
                          icon: Icons.person,
                          hint: 'Full Name',
                          controller: nameController,
                        )
                      : Text(
                          nameController.text,
                          style: const TextStyle(color: Colors.white, fontSize: 30),
                        ),
                  const SizedBox(height: 10),

                  // Email
                  isEditing
                      ? CustomInputField(
                          icon: Icons.email,
                          hint: 'Email',
                          controller: emailController,
                        )
                      : Text(
                          emailController.text,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                  const SizedBox(height: 10),

                  // Phone
                  isEditing
                      ? CustomInputField(
                          icon: Icons.phone,
                          hint: 'Phone',
                          controller: phoneController,
                        )
                      : Text(
                          phoneController.text,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                  const SizedBox(height: 30),


                  const SizedBox(height: 20),

                  // Buttons
                  if (isEditing)
                    PrimaryButton(
                      text: 'Save',
                      onPressed: saveDetails,
                    )
                  else
                    PrimaryButton(
                      text: 'Edit Details',
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                    ),

                  const SizedBox(height: 10),
                  PrimaryButton(
                    text: 'Back',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
    );
  }
}
