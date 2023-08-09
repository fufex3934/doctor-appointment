import 'package:doctor/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientRegistration extends StatefulWidget {
  static const routeName = 'patient-register';

  const PatientRegistration({Key? key}) : super(key: key);

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  bool privacyPolicyAgreed = false;
  bool term_conditionAgreement = false;
  String privacyPolicy = '''Privacy Policy

Last updated: [Date]

1. Introduction

Welcome to [Your Website/App Name] ("us," "we," or "our"). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our website [www.example.com] or mobile application (the "Service"). Please read this Privacy Policy carefully. By accessing or using the Service, you consent to the practices described in this Privacy Policy.

2. Information We Collect

We may collect and process the following types of personal information about you:

- Information you provide directly: We may collect personal information that you provide directly when you [register, fill out forms, make a purchase, or interact with the Service].

- Automatically collected information: We may collect certain information automatically when you access and use the Service. This information may include [your IP address, device type, browser type, operating system, and usage information].

3. Use of Information

We may use the information we collect for various purposes, including:

- To provide and maintain the Service
- To process your transactions
- To improve the Service
- To send you promotional materials and newsletters
- To respond to your inquiries and provide customer support

4. Sharing of Information

We may share your information with third parties in the following circumstances:

- With service providers: We may share your information with third-party service providers who perform services on our behalf.
- For legal purposes: We may share your information in response to a subpoena, court order, or government request.
- With your consent: We may share your information with your consent.

5. Cookies and Similar Technologies

We may use cookies and similar technologies to collect information about your interactions with the Service. You can manage your cookie preferences through your browser settings.

6. Security

We use reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no data transmission over the internet or method of electronic storage is entirely secure.

7. Third-Party Links

The Service may contain links to third-party websites or services. We are not responsible for the practices of such third parties.

8. Children's Privacy

The Service is not directed to individuals under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us.

9. Changes to This Privacy Policy

We may update this Privacy Policy from time to time. The updated version will be indicated by the "Last updated" date at the top of this page.

10. Contact Us

If you have any questions or concerns about this Privacy Policy, please contact us at [your email address].

''';
  String termsAndConditions = ''' 
  Terms and Conditions

  Last updated: [Date]

  1. Introduction

  Welcome to [Your Doctor-Patient Meeting App Name] ("us," "we," or "our"). These Terms and Conditions govern your use of our app. By using the app, you agree to comply with these terms. Please read them carefully.

  2. Acceptance of Terms

  By using the app, you accept and agree to be bound by these Terms and Conditions. If you do not agree, please do not use the app.

  3. Eligibility

  You must be [age] years old or older to use this app. By using the app, you represent and warrant that you meet the eligibility requirements.

  4. User Accounts

  To access certain features, you may need to create a user account. You are responsible for maintaining the confidentiality of your account information and agree to accept responsibility for all activities that occur under your account.

  5. Services and Scope

  Our app provides a platform for doctors and patients to connect and schedule appointments. However, we do not provide medical services. Our app does not establish a doctor-patient relationship. It is essential to consult a qualified healthcare professional for medical advice.

  6. User Conduct

  You agree not to use the app for any unlawful or abusive purposes. You shall not engage in spamming, hacking, or any activities that may harm the app or its users.

  7. Intellectual Property Rights

  The app and its content are protected by intellectual property laws. You may not copy, modify, or distribute the app's content without our prior written consent.

  8. Privacy and Data Protection

  We collect and process your data in accordance with our Privacy Policy. By using the app, you consent to our data practices.

  9. Communications

  By using the app, you agree to receive communications from us, such as notifications and emails. You may opt-out of marketing communications.

  10. Indemnification

  You agree to indemnify and hold us harmless from any claims, damages, or losses arising from your use of the app.

  11. Dispute Resolution and Governing Law

  Any disputes arising from the use of the app shall be resolved according to the laws of [Jurisdiction]. You agree to submit to the exclusive jurisdiction of the courts in [Jurisdiction].

  12. Limitation of Liability

  We shall not be liable for any damages or losses arising from your use of the app. Our total liability shall not exceed the amount paid, if any, by you for using the app.

  13. Modifications and Termination

  We reserve the right to modify or terminate the app and these terms at any time. Changes will be effective upon posting on the app.

  14. Miscellaneous

  If any provision of these Terms and Conditions is deemed invalid or unenforceable, the remaining provisions shall remain in full force and effect. These terms constitute the entire agreement between you and us.

  If you have any questions or concerns about these terms, please contact us at [your email address].
  ''';

  void _showRequiredInformationDialog(title, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(text),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _birthdateController = TextEditingController();
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _agreedToPrivacyPolicy = false;

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

  //register function

  Future<void> _registerPatient() async {
    if (term_conditionAgreement && privacyPolicyAgreed) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final url = 'http://192.168.0.150:3000/users/register/patients';
        final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'fullName': _fullName,
            'email': _email,
            'password': _password,
            'birthDate': _selectedDate?.toIso8601String() ?? '',
          }),
        );

        if (response.statusCode == 201) {
          print(_fullName);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          print('Response Status Code: ${response.statusCode}');
          print('Response Body: ${response.body}');
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  "Please Check the privacy policy and terms and conditions agreement"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  //email validation
  bool isValidEmail(String email) {
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 40.0, bottom: 20.0),
                  child: Text(
                    "Register Here",
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter Your Full Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add email format validation here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _fullName = value!;
                  },
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }else if (!isValidEmail(value.toString())) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
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
                        child: TextFormField(
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
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }

                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }

                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return 'Password must contain at least one lowercase letter';
                    }

                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one digit';
                    }

                    // Add more checks for special characters if desired

                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
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
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Confirm Your Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    // Add password matching validation here
                    if (_confirmPassword != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _confirmPassword = value!;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: privacyPolicyAgreed,
                      onChanged: (value) {
                        setState(() {
                          privacyPolicyAgreed = !privacyPolicyAgreed;
                        });
                      },
                    ),
                    Expanded(
                      child: Text("I agree to Privacy Policy"),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            _showRequiredInformationDialog(
                                'Privacy Policy', privacyPolicy);
                          },
                          child: Text("Read...")),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: term_conditionAgreement,
                      onChanged: (value) {
                        setState(() {
                          term_conditionAgreement = !term_conditionAgreement;
                        });
                      },
                    ),
                    Expanded(child: Text("agree to Terms and Conditions")),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            _showRequiredInformationDialog(
                                'Terms and Condition', termsAndConditions);
                          },
                          child: Text("Read...")),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Already have Account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Login",
                        )), //takes the doctor from registration to login
                  ],
                ),
                ElevatedButton(
                  onPressed: _registerPatient,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1e40af),
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
      ),
    );
  }
}
