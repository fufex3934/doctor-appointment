import 'package:doctor/view/4Patient/individualDoctorsInfo/IndividualDoctorsInfo.dart';
import 'package:doctor/view/4Patient/profile.dart';
import '../../chat_page.dart';
import 'package:doctor/view/doctorsPage/doctor_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor/controller/Provider.dart';
import '../../../model/listCategory.dart';
import 'package:http/http.dart' as http;
import '../../../assets/images/port/deviceIp.dart';
import 'dart:convert';

class CategoryChoice extends StatefulWidget {
  const CategoryChoice({Key? key}) : super(key: key);

  @override
  State<CategoryChoice> createState() => _CategoryChoiceState();
}

RatingStars rs = RatingStars(rating: 3);

final List<Category> menu = [
  Category(
      name: 'drug',
      Image: Image.asset(
        'lib/assets/images/drug.jpg',
        height: 50,
        width: 80,
      )),
  Category(
      name: 'Virus',
      Image: Image.asset(
        'lib/assets/images/virus.jpg',
        height: 50,
        width: 80,
      )),
  Category(
      name: 'Psycho',
      Image: Image.asset(
        'lib/assets/images/psycho.jpg',
        height: 50,
        width: 80,
      )),
  Category(
      name: 'Other',
      Image: Image.asset(
        'lib/assets/images/other.png',
        height: 50,
        width: 80,
      )),
];
// List<DoctorsList> docList = [
//   DoctorsList(
//       name: 'Doctors Name',
//       bg: 'lib/assets/images/drug.jpg',
//       Speciality: "Heart Break Speciality",
//       Image: Image.asset(
//         'lib/assets/images/drug.jpg',
//         width: 75,
//         height: 75,
//         fit: BoxFit.cover,
//       ),
//       Rating: 5),
//   DoctorsList(
//       name: 'Doctors Name',
//       bg: 'lib/assets/images/drug.jpg',
//       Speciality: "Heart Break Speciality",
//       Image: Image.asset(
//         'lib/assets/images/drug.jpg',
//         width: 75,
//         height: 75,
//         fit: BoxFit.cover,
//       ),
//       Rating: 4),
//   DoctorsList(
//       name: 'Doctors Name',
//       bg: 'lib/assets/images/drug.jpg',
//       Speciality: "Heart Break Speciality",
//       Image: Image.asset(
//         'lib/assets/images/drug.jpg',
//         width: 75,
//         height: 75,
//         fit: BoxFit.cover,
//       ),
//       Rating: 5),
//   DoctorsList(
//       name: 'Doctors Name',
//       bg: 'lib/assets/images/drug.jpg',
//       Speciality: "Heart Break Speciality",
//       Image: Image.asset(
//         'lib/assets/images/drug.jpg',
//         width: 75,
//         height: 75,
//         fit: BoxFit.cover,
//       ),
//       Rating: 3),
//   DoctorsList(
//       name: 'Doctors Name',
//       bg: 'lib/assets/images/drug.jpg',
//       Speciality: "Heart Break Speciality",
//       Image: Image.asset(
//         'lib/assets/images/drug.jpg',
//         width: 75,
//         height: 75,
//         fit: BoxFit.cover,
//       ),
//       Rating: 4),
// ];
List<DoctorsList> doctorsList = [];
Future<void> getDoctors() async {
  final response = await http.get(
    Uri.parse('http://${IpAddress()}:3000/users/Doctor/get-Doctors'),
    headers: {'Content-Type': 'application/json'},
  );

  final data = json.decode(response.body);

  if (data != null) {
    print(data);

    // Cast the mapped data to a List<DoctorsList>
    doctorsList = List<DoctorsList>.from(data.map((value) {
      print("--------------------");
      print(value);
      print(value['fullName']);
      print(value['specialization']);
      print("--------------------");

      return DoctorsList(
        id: value['_id'],
        name: value['fullName'],
        Speciality: value['specialization'],
        Rating: 3,
        bg: 'lib/assets/images/drug.jpg',
        Image: Image.asset(
          'lib/assets/images/drug.jpg',
          width: 75,
          height: 75,
          fit: BoxFit.cover,
        ),
      );
    }));

    // Now, doctorsList contains the mapped data

    print("----------------------------------------------------");
  }

  // return (data['status'] == true);
}

List<Widget> personCards = menu.map((ele) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ele.Image, Text(ele.name)],
    ),
  );
}).toList();

class _CategoryChoiceState extends State<CategoryChoice> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // List<Widget> listDoctors = doctorsList.map((ele) {
    //   return

    // Card(
    //   child: Container(
    //     padding: const EdgeInsets.all(10),
    //     child: Row(
    //       children: [
    //         ClipOval(
    //           child: ele.Image,
    //         ),
    //         const SizedBox(
    //           width: 30,
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               ele.name,
    //               style:
    //                   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //             ),
    //             Text(ele.Speciality,
    //                 style: const TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.normal,
    //                     color: Colors.grey)),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: List.generate(5, (index) {
    //                 return IconTheme(
    //                   data: IconThemeData(
    //                     color:
    //                         index < RatingStars(rating: ele.Rating).rating.floor()
    //                             ? rs.color
    //                             : rs.borderColor,
    //                     size: rs.size,
    //                   ),
    //                   child: Icon(Icons.star),
    //                 );
    //               }),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // }).toList();
    // Add dividers between the tiles
    // List<Widget> dividedListDoctors = [];
    // for (var i = 0; i < listDoctors.length; i++) {
    //   dividedListDoctors.add(listDoctors[i]);
    //   if (i < listDoctors.length - 1) {
    //     dividedListDoctors.add(Divider(
    //       thickness: 1,
    //       height: 5,
    //     ));
    //   }
    // }
    final patientProvider = Provider.of<PatientProvider>(context);

    int _selectedIndex = 0;

    // Define the pages corresponding to each tab
    final List<Widget> _pages = [
      CategoryChoice(),
      ChatPage(
        senderEmail: patientProvider.patient?.loggedInUserData['email'],
        senderId: patientProvider.patient?.loggedInUserData['_id'],
        recieverEmail: "",
        recieverId: "",
      ),
      ChatPage(
        senderEmail: patientProvider.patient?.loggedInUserData['email'],
        senderId: patientProvider.patient?.loggedInUserData['_id'],
        recieverEmail: "",
        recieverId: "",
      ),
      PatientProfile(),
    ];

    // Function to handle tab navigation
    void _onTabTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => _pages[_selectedIndex]));
    }

    getDoctors();
    return Scaffold(
      body: Center(
          child: Container(
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello ,',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                        '${patientProvider.patient?.loggedInUserData['fullName']}',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ],
                ),
                Icon(Icons.notifications_none)
              ]),
              const SizedBox(
                height: 30,
              ),
              TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    // Add a clear button to the search bar
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'lib/assets/images/image3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          child: const Text(
                              'You are Invited to Join Live Stream with Dr.Navida',
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.clip),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const Row(
                      children: [
                        Text(
                          "120k people join Live Streaming !",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: personCards,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Our Doctors",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    child: const Text("See All"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DoctorPage(data: doctorsList)));
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                  height: 254,
                  //   child: SingleChildScrollView(
                  //       scrollDirection: Axis.vertical,
                  //       child: Column(children: dividedListDoctors)),

                  child: FutureBuilder<void>(
                    future: getDoctors(), // Your data fetching function
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show a loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Data is available, render your widgets
                        return ListView.builder(
                          itemCount: doctorsList.length,
                          itemBuilder: (context, index) {
                            // Create and return your ListTile widgets here
                            return Column(
                              children: [
                                ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage(doctorsList[index].bg),
                                    ),
                                    title: Text(doctorsList[index].name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(doctorsList[index].Speciality),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(5, (index) {
                                            return IconTheme(
                                              data: IconThemeData(
                                                color: index <
                                                        RatingStars(
                                                                rating:
                                                                    doctorsList[
                                                                            index]
                                                                        .Rating)
                                                            .rating
                                                            .floor()
                                                    ? rs.color
                                                    : rs.borderColor,
                                                size: rs.size,
                                              ),
                                              child: Icon(Icons.star),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      // Your onClick functionality here
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => IndDoctorsInfo(
                                                doctorInfo:
                                                    IndividualDoctorsInformation(
                                                        doctorId: doctorsList[
                                                                index]
                                                            .id,
                                                        name: doctorsList[index]
                                                            .name,
                                                        speciality:
                                                            doctorsList[index]
                                                                .Speciality,
                                                        photo:
                                                            doctorsList[index]
                                                                .bg,
                                                        Rating:
                                                            doctorsList[index]
                                                                .Rating)),
                                          ));
                                    }),
                                Divider(
                                  color: Colors.black,
                                  indent: 12,
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                  )),
            ],
          ),
        ),
      )),
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
