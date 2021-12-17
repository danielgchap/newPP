import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'create_group.dart';
import 'my_groups_list.dart';
import 'lists_temporary_approach/my_pending_requests.dart';

//////////////////////////////////////////////////////////////////////////
//
//     the gateway to the group section. This will list all the Pending groups
//     that the user has requested and should also list groups the user has
//     been invited to. Have not programmed this. It should show an X to cancel
//     previous requests and give an option to accept or reject if user was invited
//     My goupd section list the groups that the user is a part of. If the user
//     is an admin, the text should be blue to indicate status. Two buttons are
//     at the bottom for joining a group, which goes to the search page and
//     start group, which should pop up an inApp purchase.
//
//////////////////////////////////////////////////////////////////////////

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({Key? key}) : super(key: key);

  @override
  _ConnectionsPageState createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.connections,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            _headerSection(context, StringConstants.pendingRequests),
            PendingRequests(),
            _headerSection(context, StringConstants.myGroups),
            MyGroups(),
            const SizedBox(height: 15),
            _buttonsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context, _title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 10, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonsSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PPCRoundedButton(
          title: StringConstants.joinGroup,
          buttonRatio: .6,
          buttonWidthRatio: .5,
          callback: () {
            Navigator.pushNamed(context, '/GroupSearchPage');
          },
          bgColor: Colors.lightBlueAccent.shade100,
          textColor: Colors.white,
        ),
        PPCRoundedButton(
          title: StringConstants.startGroup,
          buttonRatio: .6,
          buttonWidthRatio: .5,
          callback: () {
            bool isCreating = true;
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CreateGroupWidget(context, isCreating: isCreating));
          },
          bgColor: Colors.lightBlueAccent.shade100,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
