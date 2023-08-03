import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorPage extends StatefulWidget {
  static const routeName = 'doctor-page';

  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late GoogleMapController _mapController;
  final LatLng _doctorLocation = const LatLng(37.7749, -122.4194); // Example doctor's location
  Set<Marker> _markers = {}; // Set of markers


  @override
  void initState() {
    super.initState();
    _addDoctorMarker();
  }

  void _addDoctorMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('doctor_marker'),
          position: _doctorLocation,
          infoWindow: const InfoWindow(
            title: 'Doctor Location',
            snippet: 'Doctor Address',
          ),
        ),
      );
    });
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
                        backgroundImage: AssetImage('assets/images/heartbeat.png'),
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

                                fontWeight: FontWeight.w300
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
                          target: _doctorLocation,
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
                        minMaxZoomPreference: const MinMaxZoomPreference(10, 18),
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
             const SizedBox(height: 20.0,),
             Row(
              children: [
                const Text(
                    "Nearby Doctors",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway"
                  ),
                ),
                const Spacer(),
                TextButton(onPressed: (){},
                    child: const Text("see all")
                )
              ],
            ),
             const SizedBox(height: 20,),
              Column(
              children: [
                Dismissible(
                  key:const Key('doctor1'),
                  direction: DismissDirection.horizontal,
                  background: Container(
                  height: 200,
                    width: 200,
                    alignment: Alignment.topRight,
                    decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff1e40af),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.only(top: 8.0,right: 8.0,bottom: 8.0),
                      child:  CircleAvatar(
                        backgroundColor: Colors.white60,
                        radius: 15,
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    setState(() {
                     // Navigator.pushNamed(context, 'main');
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: const Row(
                      children: [
                       CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/doctor1.jpg',
                          ),
                        ),
                       SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(
                              "Dr.Novida Navara",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w700
                              ),
                            ),

                            Text(
                              "Heart Break Specialist",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Dismissible(
                  key:const Key('doctor2'),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.topRight,
                    decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff1e40af),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.only(top: 8.0,right: 8.0,bottom: 8.0),
                      child:  CircleAvatar(
                        backgroundColor: Colors.white60,
                        radius: 15,
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    setState(() {
                      // Navigator.pushNamed(context, 'main');
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/doctor4.jpg',
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(
                              "Dr.Romans Begins",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700
                              ),
                            ),

                            Text(
                              "Internal Organ Specialist",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Dismissible(
                  key:const Key('doctor3'),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.topRight,
                    decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff1e40af),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.only(top: 8.0,right: 8.0,bottom: 8.0),
                      child:  CircleAvatar(
                        backgroundColor: Colors.white60,
                        radius: 15,
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    setState(() {
                      // Navigator.pushNamed(context, 'main');
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/doctor2.jpg',
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(
                              "Dr.Fufa Wakgari",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700
                              ),
                            ),

                            Text(
                              "Brain Break Specialist",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],

        ),
      ),
    );
  }
}
