import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/providers.dart';
import 'package:prayer_pals/core/widgets/ppc_alert_dialog.dart';
import 'package:prayer_pals/features/group/providers/group_member_provider.dart';
import 'package:prayer_pals/features/group/providers/group_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:prayer_pals/core/utils/constants.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Creates group and creates first group member as admin and owner
//     isOwner should be used in determining if an admin can resign as admin
//     or kill the group. Owner should assign a new owner when leaving the
//     group or understand that it will kill the group. Multiple admins can be
//     assigned, but only one owner.
//
//////////////////////////////////////////////////////////////////////////

class CreateGroupWidget extends StatelessWidget {
  final bool isCreating;

  CreateGroupWidget(BuildContext context, {Key? key, required this.isCreating})
      : super(key: key);

  final TextEditingController _groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        StringConstants.createGroup,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            style: const TextStyle(
              fontFamily: 'Helvetica',
            ),
            textInputAction: TextInputAction.done,
            controller: _groupNameController,
            decoration: const InputDecoration(
              hintText: StringConstants.groupName,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            // Navigator.of(context).pop();
            _createGroup(context);
          },
          child: const Text(StringConstants.save),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(StringConstants.cancel),
        ),
      ],
    );
  }

  _createGroup(BuildContext ctx) async {
    Uuid uuid = const Uuid();
    String groupId = uuid.v1();
    final userUID = ctx.read(firebaseAuthProvider).currentUser!.uid;
    final srvMsg = await ctx.read(groupControllerProvider).createGroup(
          groupId,
          _groupNameController.text,
          "",
          userUID,
          true,
          "",
        );
    if (srvMsg == StringConstants.success) {
      String groupName = _groupNameController.text;
      _joinGroup(ctx, groupId, groupName);
    } else {
      showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
    }
  }

  _joinGroup(BuildContext ctx, groupId, groupName) async {
    final groupMemberUID = ctx.read(firebaseAuthProvider).currentUser!.uid;
    final groupMemberName =
        ctx.read(firebaseAuthProvider).currentUser!.displayName;
    final groupUID = groupId;
    final emailAddress = ctx.read(firebaseAuthProvider).currentUser!.email;
    const phoneNumber = "";
    final srvMsg = await ctx
        .read(groupMemberControllerProvider)
        .createGroupMember(
            groupMemberUID,
            groupMemberName!,
            groupName,
            groupUID,
            true,
            true,
            false,
            false,
            emailAddress!,
            phoneNumber,
            true,
            false,
            false,
            false);
    if (srvMsg == StringConstants.success) {
      Navigator.of(ctx).pop();
    } else {
      showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
    }
  }
}
