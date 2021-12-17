import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prayer_pals/core/utils/constants.dart';

class UpdatePicture extends StatefulWidget {
  UpdatePicture(BuildContext context, {Key? key}) : super(key: key);

  @override
  _UpdatePictureState createState() => _UpdatePictureState();
}

class _UpdatePictureState extends State<UpdatePicture> {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        StringConstants.updateProfilePicture,
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () async {
            await ImagePicker().pickImage(source: ImageSource.gallery);
          },
          child: const Text(StringConstants.photos),
        ),
        new ElevatedButton(
          onPressed: () async {
            await ImagePicker().pickImage(source: ImageSource.camera);
          },
          child: const Text(StringConstants.camera),
        ),
      ],
    );
  }
}
