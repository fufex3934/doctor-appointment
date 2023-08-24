import 'dart:convert';

import 'package:doctor/controller/Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import '../../../assets/images/port/deviceIp.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  File? _image;
  File? _imageFileForUpload;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    _updateProfileImage(pickedImage);
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    _updateProfileImage(pickedImage);
  }

  void _updateProfileImage(XFile? pickedImage) {
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _imageFileForUpload = File(pickedImage.path);
      }
    });
  }

  // ... other methods ...
 
  List<Map<String, String>> patientInfo = [
    {"Age": "38"},
    {"Gender": "M"},
    {"DOB": "Jan 18 1982"},
    {"Fathers Name ": "aaaa"},
    {"Mothers Name ": "bbb"},
    {"Blood Type ": "A+"},
    {"Weight": "72"},
    {"Height": "55'"},
    {"Alergy": "cccc"}
  ];

  List<Map<String, String>> addressInfo = [
    {"Place ": "1168 pw parners rd, portland,USA"},
    {"Phone": "384889977746"},
    {"Alt Phone": "4567890983"},
    {"Email": "fufa@gmail.com"},
  ];

  bool editProfile = false;
  bool editPatientInfo = false;
  bool editAddress = false;
  TextEditingController _patientNameController = TextEditingController();

  // Create a list of TextEditingController instances
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _controllersAddress = [];

  @override
  void initState() {
    super.initState();

    // Initialize TextEditingController instances with initial values
    for (var info in patientInfo) {
      _controllers.add(TextEditingController(text: info.values.first));
    }
    for (var address in addressInfo) {
      _controllersAddress
          .add(TextEditingController(text: address.values.first));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var controllerAdd in _controllersAddress) {
      controllerAdd.dispose();
    }
    super.dispose();
  }

  void onSave() {
    // Iterate through controllers and update the data
    for (int i = 0; i < patientInfo.length; i++) {
      patientInfo[i][patientInfo[i].keys.first] = _controllers[i].text;
    }
    for (int i = 0; i < addressInfo.length; i++) {
      addressInfo[i][addressInfo[i].keys.first] = _controllersAddress[i].text;
    }

    // Toggle edit mode after saving
    setState(() {
      editPatientInfo = !editPatientInfo;
    });
  }

  List<String> parameters = ['nameAndImage', 'profileInfo', 'addressInfo'];

//TODO : SAVE EDITED VALUES TO DATABASE

  Future<bool> ChangeName(String id, Map<String, dynamic> finalData) async {
    var uniqueFilename =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://${IpAddress()}:3000/users/patient/profile-edit/$id'),
    );

    // if (_imageFileForUpload != null) {
    //   var imagePart = await http.MultipartFile.fromPath(
    //     'profileImage', // Field name on the server for the image
    //     _imageFileForUpload!.path,
    //   );
    //   request.files.add(imagePart);
    // }
    request.files.add(
      http.MultipartFile(
        'profileImage', // Field name on the server for the image
        _image!.readAsBytes().asStream(),
        _image!.lengthSync(),
        filename: uniqueFilename, // You can generate a unique filename here
      ),
    );

    for (var entry in finalData.entries) {
      request.fields[entry.key] = entry.value.toString();
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.camera),
                                        title: Text('Take a Photo'),
                                        onTap: () {
                                          _getImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.image),
                                        title: Text('Choose from Gallery'),
                                        onTap: () {
                                          _getImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          editProfile
                              ? SizedBox(
                                  width: 120,
                                  child: TextField(
                                    controller: _patientNameController,
                                    decoration:
                                        InputDecoration(labelText: "Name "),
                                  ),
                                )
                              : Text(
                                  _patientNameController.text.isEmpty
                                      ? "patient name".capitalize()
                                      : _patientNameController.text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Patient Id 12467577".toUpperCase(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "since oct 7,2023".toUpperCase(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    editProfile = !editProfile;
                                  });
                                },
                                icon: Icon(Icons.edit)),
                            Expanded(
                              child: Container(
                                child: editProfile
                                    ? IconButton(
                                        onPressed: () async {
                                          print(_patientNameController.text);

                                          setState(() {
                                            editProfile = false;
                                          });
                                          bool nameChanged =
                                              await ChangeName(parameters[0], {
                                            "name": _patientNameController.text,
                                            'profileImage': _image,
                                            "userId": patientProvider.patient
                                                ?.loggedInUserData['_id']
                                          });
                                          print(nameChanged);
                                        },
                                        icon: Icon(Icons.save),
                                      )
                                    : null,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.text_snippet,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Patient Info".capitalize(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          editPatientInfo = !editPatientInfo;
                                        });
                                      },
                                      icon: Icon(Icons.edit)),
                                  Container(
                                      child: editPatientInfo
                                          ? IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  for (int i = 0;
                                                      i < _controllers.length;
                                                      i++) {
                                                    print(_controllers[i].text);
                                                  }
                                                  editPatientInfo = false;
                                                });
                                                bool nameChanged =
                                                    await ChangeName(
                                                        parameters[1], {
                                                  "Age": _controllers[0].text,
                                                  "Gender":
                                                      _controllers[1].text,
                                                  "DOB": _controllers[2].text,
                                                  "Fathers_Name ":
                                                      _controllers[3].text,
                                                  "Mothers_Name ":
                                                      _controllers[4].text,
                                                  "Blood_Type ":
                                                      _controllers[5].text,
                                                  "Weight":
                                                      _controllers[6].text,
                                                  "Height":
                                                      _controllers[7].text,
                                                  "Alergy":
                                                      _controllers[8].text,
                                                  "userId": patientProvider
                                                      .patient
                                                      ?.loggedInUserData['_id']
                                                });
                                                print(nameChanged);
                                              },
                                              icon: Icon(Icons.save))
                                          : null)
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < patientInfo.length; i++)
                                editPatientInfo
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${patientInfo[i].keys.first} :",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          SizedBox(
                                            width: 120,
                                            height: 25,
                                            child: TextField(
                                              // info.values.first,
                                              controller: _controllers[i],
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          )
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patientInfo[i].keys.first,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            _controllers[i].text.isEmpty
                                                ? patientInfo[i].values.first
                                                : _controllers[i].text,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.home_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Address".capitalize(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 110,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          editAddress = !editAddress;
                                        });
                                      },
                                      icon: Icon(Icons.edit)),
                                  Container(
                                    child: editAddress
                                        ? IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                editAddress = false;
                                                for (int i = 0;
                                                    i <
                                                        _controllersAddress
                                                            .length;
                                                    i++) {
                                                  print(_controllersAddress[i]
                                                      .text);
                                                }
                                              });
                                              bool nameChanged =
                                                  await ChangeName(
                                                      parameters[2], {
                                                "Place":
                                                    _controllersAddress[0].text,
                                                "Phone":
                                                    _controllersAddress[1].text,
                                                "Alt_Phone":
                                                    _controllersAddress[2].text,
                                                "Email":
                                                    _controllersAddress[3].text,
                                                "userId": patientProvider
                                                    .patient
                                                    ?.loggedInUserData['_id']
                                              });
                                              print(nameChanged);
                                            },
                                            icon: Icon(Icons.save))
                                        : null,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < addressInfo.length; i++)
                                editAddress
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${addressInfo[i].keys.first} :",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          SizedBox(
                                            width: 220,
                                            height: 45,
                                            child: TextField(
                                              controller:
                                                  _controllersAddress[i],
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addressInfo[i].keys.first,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                            width: 230,
                                            child: Text(
                                              _controllersAddress[i]
                                                      .text
                                                      .isEmpty
                                                  ? addressInfo[i].values.first
                                                  : _controllersAddress[i].text,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
