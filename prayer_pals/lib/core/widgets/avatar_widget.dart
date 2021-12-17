import 'package:flutter/material.dart';

class PPCAvatar extends StatelessWidget {
  final double radSize;
  final String image;

  const PPCAvatar({Key? key, required this.radSize, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasPicture = true; //change to passed in value

    if (hasPicture == true) {
      return CircleAvatar(foregroundImage: AssetImage(image), radius: radSize);
    } else {
      return CircleAvatar(
        backgroundColor: Colors.grey.shade500,
        child: const Text(''),
        radius: radSize,
      );
    }
  }
}
