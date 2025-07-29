import 'package:flutter/material.dart';

/// 🔵 Custom Text Field Widget
class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    required this.icon,
    required this.hint,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF0052CC), // Matches the app's blue
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// 🔵 Primary Button Widget
class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = Colors.white,
    this.textColor = const Color(0xFF0052CC),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: textColor),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text.toUpperCase()),
      ),
    );
  }
}
