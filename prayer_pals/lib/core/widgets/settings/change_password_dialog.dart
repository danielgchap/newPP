import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/utils/credential_textfield.dart';

class ChangePasswordDialog extends HookWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  ChangePasswordDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        StringConstants.changePassword,
      ),
      content: SizedBox(
        height: 220,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CredentialTextfield(
              controller: _oldPasswordController,
              hintText: StringConstants.oldPassword,
              obscure: true,
            ),
            const SizedBox(height: 20),
            CredentialTextfield(
              controller: _newPasswordController,
              hintText: StringConstants.newPassword,
              obscure: true,
            ),
            const SizedBox(height: 20),
            CredentialTextfield(
              controller: _verifyPasswordController,
              hintText: StringConstants.verifyPassword,
              obscure: true,
            ),
          ],
        ),
      ),
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
              await FirebaseAuth.instance.currentUser!
                  .updatePassword(_verifyPasswordController.text);
              return Navigator.of(context).pop();
            } catch (e) {
              debugPrint(e.toString());
              return;
            }
          },
          child: const Text(StringConstants.changePassword),
        ),
      ],
    );
  }
}
