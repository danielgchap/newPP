// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PPCAvatar extends StatelessWidget {
  final double radSize;
  final String image;
  String? networkImage;

  PPCAvatar({
    Key? key,
    required this.radSize,
    required this.image,
    this.networkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasPicture = true; //change to passed in value

    if (hasPicture == true) {
      if (networkImage == null) {
        return CircleAvatar(
            foregroundImage: AssetImage(image), radius: radSize);
      } else {
        return CircleAvatar(
            child: Image.network(networkImage!), radius: radSize);
      }
    } else {
      return CircleAvatar(
        backgroundColor: Colors.grey.shade500,
        child: const Text(''),
        radius: radSize,
      );
    }
  }
}
