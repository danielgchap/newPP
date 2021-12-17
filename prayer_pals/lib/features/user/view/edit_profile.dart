import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/credential_textfield.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/core/widgets/update_profile_pic.dart';
import 'package:prayer_pals/features/user/providers/auth_providers.dart';
import 'package:prayer_pals/core/utils/constants.dart';

// need to be able to change username and phone number
// give user option to update picture choice or cancel
// Save changes needs to update Firestore
// might want to change to white background with app bar to be consistent??

class EditProfilePage extends ConsumerWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String _image = 'assets/images/user_icon.jpeg'; // Change to Firestore TODO
    SizeConfig().init(context);
    final _auth = watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(StringConstants.editProfile),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 3,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 6,
                ),
                InkWell(
                    child: PPCAvatar(radSize: 80, image: _image),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              UpdatePicture(context));
                    }),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 6,
                ),
                CredentialTextfield(
                  hintText: StringConstants.username,
                  controller: _usernameController,
                  obscure: false,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 3,
                ),
                CredentialTextfield(
                  hintText: StringConstants.emailAddress,
                  controller: _emailAddressController,
                  obscure: false,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 3,
                ),
                CredentialTextfield(
                  hintText: StringConstants.phoneNumber,
                  controller: _passwordController,
                  obscure: false,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 9,
                ),
                PPCRoundedButton(
                  title: StringConstants.saveChanges,
                  buttonRatio: .9,
                  buttonWidthRatio: .9,
                  callback: () {
                    _updateUser(_auth, context);
                  },
                  bgColor: Colors.lightBlueAccent.shade100,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 3,
                ),
                PPCRoundedButton(
                  title: StringConstants.deleteAccount,
                  buttonRatio: .9,
                  buttonWidthRatio: .9,
                  callback: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _deleteAccount(context));
                  },
                  bgColor: Colors.lightBlueAccent.shade100,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _updateUser(_auth, context) {
    FirebaseAuth.instance.currentUser!
        .updateDisplayName(_usernameController.text);
    // TODO need to perform validation before
    //  updating email address and phone number
  }

  Widget _deleteAccount(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        StringConstants.deleteAccount,
      ),
      content: Text(
          "Are you sure you want to delete this account? This action cannot be undone."),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(StringConstants.cancel),
        ),
        new ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .delete();
              await FirebaseAuth.instance.currentUser!.delete();
              return Navigator.of(context).pop();
            } catch (e) {
              print(e.toString());
              return null;
            }
          },
          child: const Text(StringConstants.deleteAccount),
        ),
      ],
    );
  }
}
