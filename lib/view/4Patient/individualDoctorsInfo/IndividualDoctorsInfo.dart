import 'package:doctor/model/listCategory.dart';
import 'package:doctor/view/4Patient/BookAppointment/bookAppointment.dart';
import 'package:flutter/material.dart';

class IndDoctorsInfo extends StatelessWidget {
  final IndividualDoctorsInformation doctorInfo;

  const IndDoctorsInfo({Key? key, required this.doctorInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      doctorInfo.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ) //to be dynamic when loaded from back
                    ,
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      doctorInfo.speciality,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.redAccent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white60),
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ratings",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '${doctorInfo.Rating} From 5',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ) //to be dynamic with data fetched
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.redAccent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white60),
                            width: 50,
                            height: 50,
                            child: Icon(Icons.people_alt_outlined)),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Patient",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "120+",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ) //to be dynamic with data fetched
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Image.asset(
                    doctorInfo.photo, // selected doctors Photo
                    width: 280,
                    height: 300,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Biography", // selected doctors biography
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextExpansion(
                  //dynamic
                  fullText:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                      " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                      "when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                      " It has survived not only five centuries, but also the leap into electronic typesetting,"
                      " remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets "
                      "containing Lorem Ipsum passages, "
                      "and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            ),
            // Text(
            //   "Schedule",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     OutlinedButton(
            //       onPressed: () {},
            //       child: Text("18"),
            //       style: ButtonStyle(
            //         // backgroundColor: MaterialStateProperty.all(Colors.indigo),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           ),
            //         ),
            //       ),
            //     ),
            //     OutlinedButton(
            //       onPressed: () {},
            //       child: Text("19"),
            //       style: ButtonStyle(
            //         // backgroundColor: MaterialStateProperty.all(Colors.indigo),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           ),
            //         ),
            //       ),
            //     ),
            //     OutlinedButton(
            //       onPressed: () {},
            //       child: Text("20"),
            //       style: ButtonStyle(
            //         // backgroundColor: MaterialStateProperty.all(Colors.indigo),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           ),
            //         ),
            //       ),
            //     ),
            //     OutlinedButton(
            //       onPressed: () {},
            //       child: Text("21"),
            //       style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all(Colors.indigo),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 49,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 17),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookAppointment(
                                doctorId: doctorInfo.doctorId,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Make an Appointment"),
                    Icon(Icons.keyboard_double_arrow_right)
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0e0985),
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextExpansion extends StatefulWidget {
  final String fullText;

  const TextExpansion({Key? key, required this.fullText}) : super(key: key);

  @override
  State<TextExpansion> createState() => _TextExpansionState();
}

class _TextExpansionState extends State<TextExpansion> {
  bool isExpanded = false;
  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    String seeMoreText = isExpanded ? "See Less" : "See More";

    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(isExpanded
                ? widget.fullText
                : widget.fullText.substring(0, 120) + " ...")),
        TextButton(child: Text(seeMoreText), onPressed: toggleExpanded)
      ],
    ));
  }
}
