import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../assets/images/port/deviceIp.dart';

import '../../controller/Provider.dart';

class AddAppointments extends StatefulWidget {
  AddAppointments({super.key});

  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {
  List<dynamic> RequesterList = [];
  List<dynamic> requesterIds = [];
  late PatientProvider doctorProvider;
  late DateTime _selectedDateTime;
  bool _hasSelectedDateTime = false;
  String ScheduledPatientId = "";

  @override
  void initState() {
    super.initState();
    doctorProvider = Provider.of<PatientProvider>(context, listen: false);
    _selectedDateTime = DateTime.now();
    getRequests();
  }

  Future<void> getRequests() async {
    final response = await http.get(
      Uri.parse(
          'http://${IpAddress()}:3000/users/Doctor/get-Requests/${doctorProvider.doctor!.loggedInUserData["_id"]}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(json.decode(response.body));

      if (data is List) {
        setState(() {
          RequesterList = data;
          print(data);

          for (var doctorData in RequesterList) {
            // List<dynamic> requests = doctorData['RequesterId'] as List;
            // for (var request in requests) {
            //   print("Requesters =====>");
            //   print(request['requesterId']);

            //   if (request['requesterId'] != null) {
            //     requesterIds.add(request['requesterId']);
            //   }
            // }
            print("-----------------------------------");
            if (doctorData != null) {
              print(doctorData['fullName']);
            } else {
              print("null");
            }
            print("-----------------------------------");
          }

          // Now you have the list of requesterIds
        });
      }
    }
    // print("Request lists : ");
    // print(RequesterList[0]["patient"]['fullName']);
    // print(RequesterList[0]["Overview"]);

    // print("----------------------------------");
  }

  // Future<void> showModal(String fullname, String overview) async {
  //   print("=================================");

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Schedule Request"),
  //         content: Container(
  //           height: 300,
  //           child: Column(children: [
  //             Text(fullname),
  //             Text(overview),
  //           ]),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () => _selectDateTime(context),
  //             child: Text('Schedule'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _selectDateTime(BuildContext context, String patientId) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _hasSelectedDateTime = true;
          ScheduledPatientId = patientId;
        });
      }
    }
  }

  Future<void> _handleScheduleButton(String patientId) async {
    if (_hasSelectedDateTime && ScheduledPatientId == patientId) {
      // Save the appointment
      // Your logic here to send the selectedDateTime and patientId to the backend
      print('Selected Date and Time: $_selectedDateTime');
      print('Patient ID: $patientId');

      final response = await http.post(
          Uri.parse(
              'http://${IpAddress()}:3000/api/users/set-Schedule/${patientId}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "doctorId": doctorProvider.doctor!.loggedInUserData["_id"],
            "schedule": _selectedDateTime.toString()
          }));

      print(response.body);
    } else {
      // Show the date/time picker
      await _selectDateTime(context, patientId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requested Appointments'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RequesterList.isEmpty
            ? Center(child: Text('No requested appointments available.'))
            : ListView.builder(
                itemCount: RequesterList.length,
                itemBuilder: (context, index) {
                  final request = RequesterList[index];
                  final overview = request['Overview'];
                  final patient = request['patient'];

                  final patientName = patient != null
                      ? patient['fullName']
                      : 'Patient Name Not Available';
                  final id = patient != null ? patient['_id'] : 'null';

                  return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(patientName),
                              Text(overview),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () => _handleScheduleButton(id),
                              child: Text(_hasSelectedDateTime &&
                                      ScheduledPatientId == id
                                  ? "Save"
                                  : "Schedule"))
                        ],
                        // Text('Selected Date and Time: ${_selectedDateTime.toString()}'),
                      ),
                      subtitle: Text(""));
                },
              ),
      ),
    );
  }
}
