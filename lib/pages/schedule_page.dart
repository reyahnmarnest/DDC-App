import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  List<String> bookedSlots = [];

  final List<String> timeSlots = [
    '10:00 AM',
    '11:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _fetchBookedSlots();
  }

  Future<void> _fetchBookedSlots() async {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isEqualTo: dateStr)
        .get();

    final slots = snapshot.docs.map((doc) => doc['time'] as String).toList();

    setState(() {
      bookedSlots = slots;
    });
  }

  Future<void> bookAppointment() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && selectedTime != null) {
      final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

      final existing = await FirebaseFirestore.instance
          .collection('appointments')
          .where('date', isEqualTo: dateStr)
          .where('time', isEqualTo: selectedTime)
          .get();

      if (existing.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This time slot is already booked.')),
        );
        _fetchBookedSlots();
        return;
      }

      await FirebaseFirestore.instance.collection('appointments').add({
        'userId': user.uid,
        'date': dateStr,
        'time': selectedTime,
        'status': 'pending',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment booked successfully')),
      );

      Navigator.pushNamedAndRemoveUntil(context, '/success', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFF0052CC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0052CC),
        elevation: 0,
        title: const Text('Schedule Appointment'),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Selected Date',
                    style: TextStyle(
                      color: Color(0xFF0052CC),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF0052CC),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          selectedTime = null;
                        });
                        _fetchBookedSlots();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052CC),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Change Date'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Select Time Slot',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((time) {
                final bool isBooked = bookedSlots.contains(time);
                final bool isSelected = time == selectedTime;

                return ChoiceChip(
                  label: Text(
                    time,
                    style: TextStyle(
                      color: isBooked
                          ? Colors.grey
                          : isSelected
                              ? Colors.white
                              : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.white,
                  onSelected: isBooked
                      ? null
                      : (_) {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                );
              }).toList(),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: bookAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0052CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
