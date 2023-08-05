import 'package:flutter/material.dart';

class PatientRegistration extends StatefulWidget {
  static const routeName = 'patient-register';
  const PatientRegistration({super.key});

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  final TextEditingController _birthdateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:  EdgeInsets.only(left:40.0,bottom:20.0),
                child:  Text(
                  "Patient Registration",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration:  InputDecoration(
                  hintText: "Enter Your Full Name",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration:  InputDecoration(
                  hintText: "Enter Your Email",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Birth Date",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _birthdateController,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Enter Your Birth Date",
                        ),
                        onChanged: (value) {
                          // Handle input changes here (if needed)
                        },
                      ),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                obscureText: true,
                decoration:  InputDecoration(
                  hintText: "Enter Your Password",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                obscureText: true,
                decoration:  InputDecoration(
                  hintText: "Confirm Your Password",
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: true, // Set the initial value here
                    onChanged: (bool? value) {
                      // Add your checkbox logic here
                    },
                  ),
                  const Text(
                    "I agree to the Privacy Policy",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your registration logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1e40af), // Add your desired color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
