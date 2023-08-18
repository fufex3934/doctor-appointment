import 'package:flutter/material.dart';
import '../../assets/images/port/deviceIp.dart';
import '../../model/appointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodayAppointments extends StatefulWidget {
  static const routeName = 'today-appointment';

  const TodayAppointments({Key? key}) : super(key: key);

  @override
  State<TodayAppointments> createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<TodayAppointments> {
  final List<AppointmentData> appointments = [
    AppointmentData(
      doctorName: "Loki Bright",
      doctorImage: 'assets/images/doctor3.jpg',
      assistantName: "Kelly Williams",
      appointmentTime: "Today 10-30 am",
      backgroundColor: const Color(0xff93c5fd),
    ),
    AppointmentData(
      doctorName: "Loyri Brison",
      doctorImage: 'assets/images/doctor1.jpg',
      assistantName: "Katherine Moss",
      appointmentTime: "Today 11-30 am",
      backgroundColor: const Color(0xfffef9c3),
    ),
    AppointmentData(
      doctorName: "OrLando Digs",
      doctorImage: 'assets/images/doctor4.jpg',
      assistantName: "Kelly Williams",
      appointmentTime: "Today 12-30 am",
      backgroundColor: const Color(0xfffef9c3),
    ),
  ];

  int _selectedIndex = 0;

  // Define the pages corresponding to each tab
  final List<Widget> _pages = [
    // CategoryChoice(),
    // ChatPage(senderEmail:patientProvider.patient?.loggedInUserData['email'],senderId:patientProvider.patient?.loggedInUserData['_id']),
    // ChatPage(senderEmail:patientProvider.patient?.loggedInUserData['email'],senderId:patientProvider.patient?.loggedInUserData['_id']),
    // PatientProfile(),
  ];

  // Function to handle tab navigation
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => _pages[_selectedIndex]));
  }

  List<dynamic> doctorsList = [];
  Future<void> getRequests() async {
    try {
      final response = await http.get(
        Uri.parse('http://${IpAddress()}:3000/users/Doctor/get-Requests'),
        headers: {'Content-Type': 'application/json'},
      );
      var data;
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }

      if (data != null) {
        print(data);

        // Cast the mapped data to a List<DoctorsList>
        // doctorsList = List<dynamic>.from(data.map((value) {

        // return DoctorsList(
        //   id: value['_id'],
        //   name: value['fullName'],
        //   Speciality: value['specialization'],
        //   Rating: 3,
        //   bg: 'lib/assets/images/drug.jpg',
        //   Image: Image.asset(
        //     'lib/assets/images/drug.jpg',
        //     width: 75,
        //     height: 75,
        //     fit: BoxFit.cover,
        //   ),
        // );
        // }));

        // Now, doctorsList contains the mapped data

        print("----------------------------------------------------");
      }
    } catch (err) {
      print(err);
    }
    // return (data['status'] == true);
  }

  Future<void> showModal() async {
    getRequests();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("title"),
          content: Text("content"),
          actions: [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.only(top: 30.0, left: 4, right: 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xfffefce8),
                      child: Icon(Icons.chevron_left),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Today's Appointment",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/doctor4.jpg'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              for (int i = 0; i < appointments.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: appointments[i].backgroundColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        appointments[i].doctorImage,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Loki Bright",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Doctors:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Kelly Williams",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.schedule,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  appointments[i].appointmentTime,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      color: Color(0xff081229),
                                    ),
                                    child: const RotatedBox(
                                      quarterTurns:
                                          1, // Rotate 90 degrees (quarter-turns 3)
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            'Consult',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: showModal,
                    child: Text("Add Appointment",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(30),
              //             ),
              //             color: Color(0xff081229),
              //           ),
              //           child: const Icon(Icons.date_range,
              //               color: Colors.white, size: 30),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(30),
              //             ),
              //             color: Color(0xffbfdbfe),
              //           ),
              //           child: const Icon(Icons.apps,
              //               color: Color(0xff081229), size: 30),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(30),
              //             ),
              //             color: Color(0xff081229),
              //           ),
              //           child: const Icon(Icons.brightness_7,
              //               color: Colors.white, size: 30),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue, // Set selected item color
        unselectedItemColor: Colors.blueGrey, // Set unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
