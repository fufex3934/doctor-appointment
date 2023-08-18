import 'package:doctor/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../assets/images/port/deviceIp.dart';

class RegisterDoctor extends StatefulWidget {
  @override
  State<RegisterDoctor> createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  int currentPageIndex = 0;
  bool privacyPolicyAgreed = false;
  bool term_conditionAgreement = false;
  List<String> doctorSpecializations = [
    'Cardiology',
    'Dermatology',
    'Endocrinology',
    'Gastroenterology',
    'Neurology',
    'Oncology',
    'Orthopedics',
    'Pediatrics',
    'Psychiatry',
    'Radiology',
    'Urology',
    'Allergy and Immunology',
    'Anesthesiology',
    'Emergency Medicine',
    'Family Medicine',
    'Gynecology',
    'Hematology',
    'Infectious Disease',
    'Nephrology',
    'Ophthalmology',
    'Pathology',
    'Physical Medicine and Rehabilitation',
    'Pulmonology',
    'Rheumatology',
    'Sleep Medicine',
    'Sports Medicine',
    // Add more specializations as needed
  ];
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

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();
  double lat = 0;
  double long = 0;

  Position _currentPosition = Position(
    longitude: 0.0,
    latitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location service is not enabled, show a dialog or a snackbar to inform the user
      print("Location service is disabled.");
      return;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permissions if not granted
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission is denied, show a dialog or a snackbar to inform the user
        print("Location permission is denied.");
        return;
      }
    }

    // Fetch the user's current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  bool _isSubmitted = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _confirmPassword(String pwd, String pwdConfirmation) {
    if (pwd != pwdConfirmation) {
      setState(() {
        // _confirmPasswordError = "Password Does not Match";
      });
    }
    return null;
  }

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

  bool isValidEmail(String email) {
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _specializationController.dispose();
    _experienceController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Register<String> ()  {
  //   return jsonEncode({
  //       'fullname': _fullnameController.text,
  //       'specialization': _specializationController.text,
  //       'experience': _experienceController.text,
  //       'email': _emailController.text,
  //       'loc_lat': lat,
  //       'loc_long': long,
  //       'password': _passwordController.text});
  // }

  Future<void> Register_Doctor() async {
    // final response = await http.post(
    //   Uri.parse('http://localhost:5000/api/users/register/patients'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<RegisterModelDoctor>{Register()}),
    // );
    //
    // if (response.statusCode == 201) {
    //   // If the server did return a 201 CREATED response,
    //   // then parse the JSON.
    //     print(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to create album.');
    // }

    // try {
    //
    //   final WebSocketChannel channel =
    //   IOWebSocketChannel.connect(Uri.parse('ws://192.168.0.169:1234'));
    //   channel.sink.add(Register());
    //   channel.stream.listen((event) {
    //     print(event);
    //     channel.sink.close();
    //   });
    // } catch (e) {
    //   print(e);
    // }

    final response = await http.post(
        Uri.parse('http://${IpAddress()}:3000/users/Doctor/RegisterDoctor'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullname': _fullnameController.text,
          'specialization': _specializationController.text,
          'experience': _experienceController.text,
          'email': _emailController.text,
          'loc_lat': lat,
          'loc_long': long,
          'password': _passwordController.text
        }));

    if (response.statusCode == 200) {
      print('message delivered successfully');
    } else {
      print('Failed to register student');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Center(
            child: Text(
          " Register Here",
          style: TextStyle(fontSize: 25),
        )),
        SizedBox(
          height: 15,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    label: Text("Full Name"),
                    hintText: "eg. Dr. John Doe",
                  ),
                  validator: (value) {
                    if (_isSubmitted && value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _specializationController,
                  decoration: InputDecoration(
                    label: Text("Specialization"),
                    hintText: "eg. Radiology",
                  ),
                  validator: (value) {
                    if (_isSubmitted && value!.isEmpty) {
                      return 'Please enter your Specialization Area';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _experienceController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    label: Text("Experience"),
                    hintText: "eg. 7",
                  ),
                  validator: (value) {
                    if (_isSubmitted && value!.isEmpty) {
                      return 'Please enter your Experience';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    hintText: "eg. JohnDoe@emailProvider.com",
                  ),
                  validator: (value) {
                    if (_isSubmitted && value!.isEmpty) {
                      return 'Please enter your Email';
                    } else if (!isValidEmail(value.toString())) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    hintText: "Enter Password",
                  ),
                  validator: (value) {
                    if (_isSubmitted && value!.isEmpty) {
                      return 'Please enter Password';
                    }
                    if (value!.length < 8) {
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
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordConfirmationController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    hintText: "Confirm Password",
                  ),
                  onChanged: (value) {
                    _confirmPassword(_passwordController.text, value);
                  },
                  validator: (value) {
                    if (_isSubmitted && value!.isEmpty) {
                      return 'Please Confirm Your Password';
                    } else if (value != _passwordController.text) {
                      return 'Password Does not Match';
                    }
                    return null;
                  },
                ),
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
                    Text(
                        "I agree to Privacy Policy") //TODO : make it to navigate to privacy policy page when text is clicked
                    ,
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
                    Text("agree to Terms and Conditions"),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              _showRequiredInformationDialog(
                                  'Terms and Condition', termsAndConditions);
                            },
                            child: Text("Read...")))
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // DropdownButton<int>(
                  //   value: currentPageIndex,
                  //   onChanged: (int? newValue) {
                  //     setState(() {
                  //       currentPageIndex = newValue!;
                  //     });
                  //   },
                  //   items: [
                  //     DropdownMenuItem(
                  //       value: 0,
                  //       child: Text('Text Box 1'),
                  //     ),
                  //     DropdownMenuItem(
                  //       value: 1,
                  //       child: Text('Text Box 2'),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 60,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        if (term_conditionAgreement && privacyPolicyAgreed) {
                          if (_formKey.currentState!.validate()) {
                            _getCurrentLocation();

                            setState(() {
                              lat = _currentPosition.latitude;
                              long = _currentPosition.longitude;
                              _isSubmitted = true;
                            });

                            Register_Doctor();
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

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => new CategoryChoice()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue, //Color(0xFF064687),
                        foregroundColor: Colors.white54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ))
      ]),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Patient Registration'),
    );
  }
}
