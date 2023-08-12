import 'package:flutter/material.dart';
import '../../model/appointment.dart';

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
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xffbfdbfe),
                  ),
                  child: const Center(
                    child: Text("Add Appointment",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Color(0xff081229),
                        ),
                        child: const Icon(Icons.date_range,
                            color: Colors.white, size: 30),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Color(0xffbfdbfe),
                        ),
                        child: const Icon(Icons.apps,
                            color: Color(0xff081229), size: 30),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Color(0xff081229),
                        ),
                        child: const Icon(Icons.brightness_7,
                            color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
