import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_pals/features/user/repositories/storage_repo.dart';
import 'package:prayer_pals/locator.dart';

class UpdatePicture extends StatefulWidget {
  final Function(File) callback;
  const UpdatePicture({
    required BuildContext context,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  _UpdatePictureState createState() => _UpdatePictureState();
}

class _UpdatePictureState extends State<UpdatePicture> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        StringConstants.updateProfilePicture,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop();
            var pickerFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickerFile != null) widget.callback(File(pickerFile.path));
          },
          child: const Text(StringConstants.photos),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop();
            var pickerFile =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (pickerFile != null) widget.callback(File(pickerFile.path));
          },
          child: const Text(StringConstants.camera),
        ),
      ],
    );
  }

  Future<void> _upload(String inputSource) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 60);
      File imageFile = File(pickedImage!.path);

      try {
        await locator.get<StorageRepo>().uploadFile(imageFile);
      } on FirebaseException catch (error) {
        debugPrint(error.toString());
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
