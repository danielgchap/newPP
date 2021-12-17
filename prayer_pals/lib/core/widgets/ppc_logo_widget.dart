import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PPCLogoWidget extends StatefulWidget {
  final double size;

  const PPCLogoWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  _PPCLogoWidgetState createState() => _PPCLogoWidgetState();
}

class _PPCLogoWidgetState extends State<PPCLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Image(image: AssetImage('assets/images/logoBlueS.png')),
      ),
      radius: 8 * widget.size,
      backgroundColor: Colors.white,
    );
  }
}
