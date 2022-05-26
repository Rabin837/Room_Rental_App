import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_rental/Screens/product_image_picker.dart';
import 'package:home_rental/controllers/data_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Location code --------------From Here to...
  final myController = TextEditingController();

  String lattitude = 'Null, Press Button';
  String longitude = 'Nul, Press Button';
  String addresss = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    String Address =
        ' ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    myController.text = Address;

    addresss = ' ${place.subLocality}, ${place.locality} ';

    setState(() {});
  }
// ----------------Upto here Location code

  DataController controller = Get.find();
  var _userImageFile;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "p_name": "",
    "p_price": 0,
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "phone_number": "",
  };

  sendmessage({String? title, String? body}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your channel id',
      'your channel name',
      description: 'your channel description',
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description)));
  }

  void _pickedImage(File image) {
    _userImageFile = image;

    print("Image got $_userImageFile");
  }

  addProduct() {
    if (_userImageFile == null) {
      Get.snackbar(
        "Opps",
        "Image Required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).errorColor,
        colorText: Colors.white,
      );
      return;
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for new product $productData');
      controller.addNewProduct(productData, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Room'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Room Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Room Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room Price Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    print(value);
                    productData['p_price'] = int.parse(value!);
                  },
                ),

                // added

                /* TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product lattitude'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['la_data'] = value!;
                  },
                ),  */

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number  Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['phone_number'] = value!;
                  },
                ),
                SizedBox(
                  height: 30,
                ),

                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your Current Location',
                    prefixIcon: Icon(Icons.add_location_outlined),
                  ),
                  controller: myController,
                ),

                //Added from Here

                // Lattitude
                SizedBox(
                  height: 0.2,
                  width: 10,
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(labelText: 'lattitude'),
                    onSaved: (value) {
                      productData['la_data'] = lattitude;
                    },
                  ),
                ),

                // Longitude
                SizedBox(
                  height: 0.2,
                  width: 10,
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(labelText: 'longtitude'),
                    onSaved: (value) {
                      productData['lo_data'] = longitude;
                    },
                  ),
                ),

                SizedBox(
                  height: 0.2,
                  width: 10,
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Location Address'),
                    onSaved: (value) {
                      productData['loc_data'] = addresss;
                    },
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      Position position = await _getGeoLocationPosition();
                      lattitude = '${position.latitude}';
                      longitude = '${position.longitude}';
                      GetAddressFromLatLong(position);
                    },
                    child: const Text(
                      "Get my current Location",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          decoration: TextDecoration.none),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.lightBlue[300],
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ))),
                  ),
                ),

                // ----------------TO here
                ProductImagePicker(_pickedImage),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    addProduct();
                    sendmessage(
                        title: "About Rooms",
                        body: "New Room is now available");
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
