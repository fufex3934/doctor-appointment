import 'package:doctor/view/4Patient/individualDoctorsInfo/IndividualDoctorsInfo.dart';
import 'package:flutter/material.dart';

import '../../../model/listCategory.dart';

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
final List<DoctorsList> docList = [
  DoctorsList(
      name: 'Doctors Name',
      bg: 'lib/assets/images/drug.jpg',
      Speciality: "Heart Break Speciality",
      Image: Image.asset(
        'lib/assets/images/drug.jpg',
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
      Rating: 5),
  DoctorsList(
      name: 'Doctors Name',
      bg: 'lib/assets/images/drug.jpg',
      Speciality: "Heart Break Speciality",
      Image: Image.asset(
        'lib/assets/images/drug.jpg',
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
      Rating: 4),
  DoctorsList(
      name: 'Doctors Name',
      bg: 'lib/assets/images/drug.jpg',
      Speciality: "Heart Break Speciality",
      Image: Image.asset(
        'lib/assets/images/drug.jpg',
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
      Rating: 5),
  DoctorsList(
      name: 'Doctors Name',
      bg: 'lib/assets/images/drug.jpg',
      Speciality: "Heart Break Speciality",
      Image: Image.asset(
        'lib/assets/images/drug.jpg',
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
      Rating: 3),
  DoctorsList(
      name: 'Doctors Name',
      bg: 'lib/assets/images/drug.jpg',
      Speciality: "Heart Break Speciality",
      Image: Image.asset(
        'lib/assets/images/drug.jpg',
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
      Rating: 4),
];

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

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listDoctors = docList.map((ele) {
      return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(ele.bg),
          ),
          title: Text(ele.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ele.Speciality),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconTheme(
                    data: IconThemeData(
                      color:
                          index < RatingStars(rating: ele.Rating).rating.floor()
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
                      doctorInfo: IndividualDoctorsInformation(
                          name: ele.name,
                          speciality: ele.Speciality,
                          photo: ele.bg,
                          Rating: ele.Rating)),
                ));
          });

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
    }).toList();
    // Add dividers between the tiles
    List<Widget> dividedListDoctors = [];
    for (var i = 0; i < listDoctors.length; i++) {
      dividedListDoctors.add(listDoctors[i]);
      if (i < listDoctors.length - 1) {
        dividedListDoctors.add(Divider(
          thickness: 1,
          height: 5,
        ));
      }
    }

    return Scaffold(
      body: Center(
          child: Container(
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ,',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        Text('Doctor Name',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black)),
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
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 254,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: dividedListDoctors)),
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
