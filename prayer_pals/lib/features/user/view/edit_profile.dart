import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/ppcuser_core_provider.dart';
import 'package:prayer_pals/core/utils/credential_textfield.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/core/widgets/update_profile_pic.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/user/clients/auth_client.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';
import 'package:prayer_pals/features/user/providers/auth_providers.dart';
import 'package:prayer_pals/core/utils/constants.dart';

// need to be able to change username and phone number
// give user option to update picture choice or cancel
// Save changes needs to update Firestore
// might want to change to white background with app bar to be consistent??

class EditProfilePage extends HookWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _auth = useProvider(authControllerProvider);
    final authClientProv = useProvider(authClientProvider);
    final user = context.read(ppcUserCoreProvider).getCurrentUserModel();

    if (user != null &&
        user.imageURL != null &&
        user.imageURL!.isNotEmpty &&
        _auth.userImage != user.imageURL) {
      _auth.updateImage(user.imageURL!);
    }

    if (_usernameController.text.isEmpty) {
      _usernameController.text = user!.username;
    }

    if (_emailAddressController.text.isEmpty) {
      _emailAddressController.text = user!.emailAddress;
    }

    if (_phoneController.text.isEmpty &&
        user != null &&
        user.phoneNumber != null) {
      _phoneController.text = user.phoneNumber!;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(StringConstants.editProfile),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 3,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 6,
                ),
                InkWell(
                    child: PPCAvatar(
                      radSize: 80,
                      image: StringConstants.userIcon,
                      networkImage: _auth.userImage,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => UpdatePicture(
                              context: context,
                              callback: (imageFile) {
                                _auth.updateUserImage(context, imageFile);
                              }));
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
                  controller: _phoneController,
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
                    _updateUser(_auth, context, user!);
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
                            _deleteAccount(context, user!, authClientProv));
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

  _updateUser(
    AuthController _auth,
    BuildContext context,
    PPCUser user,
  ) async {
    String? srvMsg = await _auth.updateUser(
        context,
        _emailAddressController.text,
        _usernameController.text,
        _phoneController.text,
        user);
    if (srvMsg != null && srvMsg == StringConstants.success) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(StringConstants.success),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(StringConstants.okCaps),
                ),
              ],
            );
          });
    }
  }

  Widget _deleteAccount(
    BuildContext context,
    PPCUser user,
    AuthClient auth,
  ) {
    return AlertDialog(
      title: const Text(
        StringConstants.deleteAccount,
      ),
      content: const Text(
          "Are you sure you want to delete this account? This action cannot be undone."),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(StringConstants.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              _deleteUser(context, user, auth);
            } catch (e) {
              _handleErrorDialog(context, e.toString());
              return;
            }
          },
          child: const Text(StringConstants.deleteAccount),
        ),
      ],
    );
  }

  _deleteUser(
    BuildContext context,
    PPCUser user,
    AuthClient auth,
  ) async {
    await FirebaseAuth.instance.currentUser!.delete().then((value) async {
      final groupRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('userGroups')
          .get();
      List<Group> groupList = [];

      for (var doc in groupRef.docs) {
        Group group = Group.fromJson(doc.data());
        if (!groupList.contains(group)) groupList.add(group);
      }

      if (groupList.isNotEmpty) {
        for (Group group in groupList) {
          //delete prayers from groups
          final collectionGroupPrayerRef = FirebaseFirestore.instance
              .collection('groups')
              .doc(group.groupUID)
              .collection('groupPrayers');

          WriteBatch batch = FirebaseFirestore.instance.batch();
          collectionGroupPrayerRef
              .where('creatorUID', isEqualTo: user.uid)
              .get()
              .then((querySnapshot) {
            for (var document in querySnapshot.docs) {
              batch.delete(document.reference);
            }
          });

          final collectionGroupsRef =
              FirebaseFirestore.instance.collection('groups');

          collectionGroupsRef
              .where('groupUID', isEqualTo: group.groupUID)
              .get()
              .then((querySnapshot) {
            for (var document in querySnapshot.docs) {
              batch.delete(document.reference);
            }
          });

          //delete user from groupMember
          final groupMemberRef = FirebaseFirestore.instance
              .collection('groups')
              .doc(group.groupUID)
              .collection(StringConstants.groupMemberCollection);

          await groupMemberRef
              .where('groupMemberUID', isEqualTo: user.uid)
              .get()
              .then((querySnapshot) {
            for (var document in querySnapshot.docs) {
              batch.delete(document.reference);
            }
          });
        }
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
      auth.signOut();
      Navigator.pushReplacementNamed(context, '/LoginPage');
    }).catchError((error) {
      _handleErrorDialog(context, error.toString());
      return null;
    });
  }

  _handleErrorDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                StringConstants.deleteAccount,
              ),
              content: Text(
                text,
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(StringConstants.okCaps),
                ),
              ],
            ));
  }

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
      });
    });

    return files;
  }
}
