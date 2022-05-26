import 'package:flutter/material.dart';
import 'package:home_rental/controllers/data_controller.dart';
import 'package:get/get.dart';

class mappage extends StatelessWidget {
  //static GoogleMapController _controller;

  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }
}
