import 'dart:convert';

import 'package:doctor/controller/Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../assets/images/port/deviceIp.dart';
import 'package:file_picker/file_picker.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  File? _image;
  File? _imageFileForUpload;
  File? _idImage;
  PlatformFile? _license;
  List<int>? _fileBytes;

  // Function to pick an image for the ID field
  Future<void> _getIdImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    _updateIdImage(pickedImage);
  }

  // Update the selected ID image
  void _updateIdImage(XFile? pickedImage) {
    setState(() {
      if (pickedImage != null) {
        _idImage = File(pickedImage.path);
      }
    });
  }

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

  // for choosing license
  Future<void> _getLicenseFromGallery() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'jpg'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile platformFile = result.files.first;
      print("Selected File: ${platformFile.name}");

      setState(() {
        _license = platformFile;
        _licensePdfController.text = platformFile.name;
        _fileBytes = null;
      });
      // Update your licenseInfo or relevant data as needed
    }
  }

  // ... other methods ...

  List<Map<String, dynamic>> doctorInfo = [
    {"FullName": "Bekalu Ato"},
    {"Specialization": "Radiology"},
    {"Experience": 7},
    {"Email": "bekalu@gmail.com"},
    {"Age": 20},
    {"Gender": "M"},
    {"Price": '100 Birr'},
    // {"Id": "Id image"},
    // {"License": "license"}
  ];

  List<Map<String, String>> addressInfo = [
    {"Place ": "1168 pw parners rd, portland,USA"},
    {"Phone": "384889977746"},
    {"Alt Phone": "4567890983"},
    {"Email": "fufa@gmail.com"},
  ];

  bool editProfile = false;
  bool editDoctorInfo = false;
  bool editAddress = false;
  TextEditingController _doctorNameController = TextEditingController();
  TextEditingController _licensePdfController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  // Create a list of TextEditingController instances
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _controllersAddress = [];

  @override
  void initState() {
    super.initState();

    // Initialize TextEditingController instances with initial values
    for (var info in doctorInfo) {
      _controllers
          .add(TextEditingController(text: info.values.first.toString()));
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
    for (int i = 0; i < doctorInfo.length; i++) {
      doctorInfo[i][doctorInfo[i].keys.first] = _controllers[i].text;
    }
    for (int i = 0; i < addressInfo.length; i++) {
      addressInfo[i][addressInfo[i].keys.first] = _controllersAddress[i].text;
    }

    // Toggle edit mode after saving
    setState(() {
      editDoctorInfo = !editDoctorInfo;
    });
  }

  List<String> parameters = ['nameAndImage', 'profileInfo', 'addressInfo'];

//TODO : SAVE EDITED VALUES TO DATABASE

  Future<bool> ChangeName(String id, Map<String, dynamic> finalData) async {
    var uniqueFilename =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://${IpAddress()}:3000/users/doctor/profile-edit/$id'),
    );

    if (id != parameters[2] && id != parameters[1]) {
      request.files.add(
        http.MultipartFile(
          'profileImage', // Field name on the server for the image
          _image!.readAsBytes().asStream(),
          _image!.lengthSync(),
          filename: uniqueFilename, // You can generate a unique filename here
        ),
      );
    }

    if (_licensePdfController.text.isNotEmpty) {
      // Convert the selected PDF file to bytes
      // List<int> pdfBytes = await _license!.readAsBytes();

      final file = File(_license!.path!);
      _fileBytes =
          await file.readAsBytes(); // Convert the selected file to bytes

      // Add the PDF file as a multipart file to the request
      request.files.add(
        http.MultipartFile(
          'licensePdf', // Field name on the server for the PDF file
          http.ByteStream.fromBytes(_fileBytes!),
          _fileBytes!.length,
          filename: _licensePdfController.text,
        ),
      );
    }

    if (_idImage != null) {
      var idImagePart = await http.MultipartFile.fromPath(
        'idImage', // Field name on the server for the ID image
        _idImage!.path,
      );
      request.files.add(idImagePart);
    }

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
                              child: editProfile
                                  ? Container(
                                      margin: EdgeInsets.only(top: 16),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ))
                                  : null,
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
                                    controller: _doctorNameController,
                                    decoration:
                                        InputDecoration(labelText: "Name "),
                                  ),
                                )
                              : Text(
                                  _doctorNameController.text.isEmpty
                                      ? "doctor name".capitalize()
                                      : _doctorNameController.text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "doctor Id 12467577".toUpperCase(),
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
                                          print(_doctorNameController.text);

                                          setState(() {
                                            editProfile = false;
                                          });
                                          bool nameChanged =
                                              await ChangeName(parameters[0], {
                                            "name": _doctorNameController.text,
                                            'profileImage': _image,
                                            "userId": patientProvider
                                                .doctor?.loggedInUserData['_id']
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
                                "Doctor Info".capitalize(),
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
                                          editDoctorInfo = !editDoctorInfo;
                                        });
                                      },
                                      icon: Icon(Icons.edit)),
                                  Container(
                                      child: editDoctorInfo
                                          ? IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  for (int i = 0;
                                                      i < _controllers.length;
                                                      i++) {
                                                    print(_controllers[i].text);
                                                  }
                                                  editDoctorInfo = false;
                                                });
                                                bool nameChanged =
                                                    await ChangeName(
                                                        parameters[1], {
                                                  "FullName":
                                                      _controllers[0].text,
                                                  "Specialization":
                                                      _controllers[1].text,
                                                  "Experience":
                                                      _controllers[2].text,
                                                  "Email": _controllers[3].text,
                                                  "Age": _controllers[4].text,
                                                  "Gender":
                                                      _controllers[5].text,
                                                  "Price": _controllers[6].text,
                                                  "userId": patientProvider
                                                      .doctor
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
                              for (int i = 0; i < doctorInfo.length; i++)
                                editDoctorInfo
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${doctorInfo[i].keys.first} :",
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
                                            doctorInfo[i].keys.first,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            _controllers[i].text.isEmpty
                                                ? doctorInfo[i].values.first
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
                            height: 5,
                          ),
                          Container(
                            width: 300,
                            child: Row(children: [
                              Text("ID Image"),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: _getIdImageFromGallery,
                                child: Text("Choose ID"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black12, // Background color
                                  foregroundColor: Colors.white, // Text color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _idImage != null
                                      ? (_idImage!.path.length > 30
                                          ? "...${_idImage!.path.substring(_idImage!.path.length - 30)}"
                                          : _idImage!.path)
                                      : "No image selected",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: 300,
                            child: Row(children: [
                              Text("License"),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: _getLicenseFromGallery,
                                child: Text("Add License"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black12, // Background color
                                  foregroundColor: Colors.white, // Text color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _licensePdfController.text.isNotEmpty
                                      ? _licensePdfController.text
                                      : "No license selected",
                                ),
                              ),
                            ]),
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
                                                "userId": patientProvider.doctor
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
