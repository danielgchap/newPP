import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/constants.dart';

class PPCmessage extends StatefulWidget {
  final String title;

  const PPCmessage({Key? key, required context, required this.title})
      : super(key: key);

  @override
  _PPCmessageState createState() => _PPCmessageState();
}

class _PPCmessageState extends State<PPCmessage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            style: TextStyle(
              fontFamily: 'Helvetica',
            ),
            textInputAction: TextInputAction.done,
            cursorColor: Colors.blue,
            maxLines: 10,
          )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            //needs to capture message and send through
            //      prefered method; text, email, or app
          },
          child: const Text(StringConstants.send),
        ),
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(StringConstants.cancel),
        ),
      ],
    );
  }
}
