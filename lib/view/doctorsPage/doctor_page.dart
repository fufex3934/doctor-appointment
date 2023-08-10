import 'dart:math';

import 'package:doctor/model/listCategory.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Doctor {
  final String name;
  final String specialty;
  final String imagePath;

  Doctor({
    required this.name,
    required this.specialty,
    required this.imagePath,
  });
}

class DoctorPage extends StatefulWidget {
  static const routeName = 'doctor-page';

  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}
RatingStars rs = RatingStars(rating: 3);

class _DoctorPageState extends State<DoctorPage> {
  late GoogleMapController _mapController;
  LatLng _userLocation = LatLng(0, 0); // User's current location
  Set<Marker> _markers = {}; // Set of markers

  List<DoctorsList> _doctors = [
    DoctorsList(
        name: 'Dr. Novida Navara',
        Speciality: 'Heart Break Specialist',
        bg: 'assets/images/doctor1.jpg',
        Image: Text('assets/images/doctor1.jpg'),
        Rating: 3),
    DoctorsList(
      name: 'Dr. Romans Begins',
      Speciality: 'Internal Organ Specialist',
      bg: 'assets/images/doctor4.jpg',
        Image: Text('assets/images/doctor4.jpg'),
      Rating:5,
    ),
    DoctorsList(
      name: 'Dr. Fufa Wakgari',
      Speciality: 'Brain Break Specialist',
      bg: 'assets/images/doctor2.jpg',
        Image: Text('assets/images/doctor2.jpg'),
      Rating: 2
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      _addDoctorMarkers();
    });
  }

  void _addDoctorMarkers() {
    // Clear existing markers
    _markers.clear();

    // Add doctor markers
    for (DoctorsList doctor in _doctors) {
      _markers.add(
        Marker(
          markerId: MarkerId(doctor.name),
          position: LatLng(_userLocation.latitude + Random().nextDouble() / 10,
              _userLocation.longitude + Random().nextDouble() / 10),
          infoWindow: InfoWindow(
            title: doctor.name,
            snippet: doctor.Speciality,
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Handle back navigation
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Our Doctors',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Handle search action
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xff1e40af),
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/heartbeat.png'),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Find Doctors!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Use this feature to find a doctor closest to you',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _userLocation,
                          zoom: 10.0,
                        ),
                        markers: _markers,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        buildingsEnabled: false,
                        compassEnabled: true,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        indoorViewEnabled: false,
                        minMaxZoomPreference:
                            const MinMaxZoomPreference(10, 18),
                        mapType: MapType.normal,
                        trafficEnabled: false,
                        liteModeEnabled: false,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text(
                  "Nearby Doctors",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text("see all"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: _doctors.map((doctor) {
                return Dismissible(
                  key: Key(doctor.name),
                  direction: DismissDirection.horizontal,
                  onDismissed: null,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E40AF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(doctor.bg),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  doctor.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  doctor.Speciality,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (index) {
                                    return IconTheme(
                                      data: IconThemeData(
                                        color:
                                        index < RatingStars(rating: doctor.Rating).rating.floor()
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
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
