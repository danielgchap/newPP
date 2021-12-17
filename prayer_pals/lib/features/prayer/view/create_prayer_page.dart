import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/utils/providers.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/ppc_alert_dialog.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/core/widgets/toggle_widget.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/home/providers/home_provider.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/providers/my_prayer_provider.dart';

// ignore: must_be_immutable
class CreatePrayerPage extends HookWidget {
  final Prayer? prayer;
  TextEditingController? _titleController;
  TextEditingController? _detailsController;
  ValueNotifier<List<String>>? _groupsToShareTo;
  ValueNotifier<List<String>>? _groupsForUpdateToAddTo;
  CreatePrayerPage({
    Key? key,
    this.prayer,
  });

  bool _shareGlobal = false;
  String? _title;
  ValueNotifier<List<String>>? _groupsToRemovePrayerFrom;

  @override
  Widget build(BuildContext context) {
    _groupsToShareTo = useState([]);
    _titleController = useTextEditingController();
    _detailsController = useTextEditingController();
    useEffect(() {
      if (prayer != null) {
        _title = StringConstants.editPrayer;
        _groupsToRemovePrayerFrom = useState([]);
        _groupsForUpdateToAddTo = useState([]);
        _groupsToShareTo!.value = prayer!.groups;
        _shareGlobal = prayer!.isGlobal;
        _titleController!.text = prayer!.title;
        _titleController!.selection = TextSelection.fromPosition(
            TextPosition(offset: _titleController!.text.length));
        _detailsController!.text = prayer!.description;
        _detailsController!.selection = TextSelection.fromPosition(
            TextPosition(offset: _detailsController!.text.length));
      } else {
        _title = StringConstants.addPrayer;
      }
    }, []);
    bool _backButton = false;
    prayer != null ? _backButton = true : _backButton = false;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title!),
        centerTitle: true,
        leading: Visibility(
          visible: _backButton,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(child: _contentSection(_backButton)),
    );
  }

  Widget _contentSection(_backButton) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 5),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: SizeConfig.safeBlockVertical! * 3.5,
            ),
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: _titleController,
            maxLength: 30,
            decoration: InputDecoration(
              hintText: StringConstants.prayerTitle,
              hintStyle: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: SizeConfig.safeBlockVertical! * 3.5,
                color: Colors.grey,
              ),
            ),
          ),
          SingleChildScrollView(
            child: TextField(
              style: TextStyle(
                fontFamily: 'Helvetica',
              ),
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: _detailsController,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.blue,
              maxLines: SizeConfig.safeBlockVertical! * 30 ~/ 20,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, -15, 0, 5),
                hintText: StringConstants.details,
                hintStyle: TextStyle(
                  fontSize: SizeConfig.safeBlockVertical! * 2.5,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
          Text(
            StringConstants.share,
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: SizeConfig.safeBlockVertical! * 4,
            ),
          ),
          SizedBox(
            child: _toggleSwitchSection(),
            height: SizeConfig.safeBlockVertical! * 28,
          ),
          _buttonSection(_backButton),
        ],
      ),
    );
  }

  Widget _toggleSwitchSection() {
    return Container(
      height: SizeConfig.screenHeight! * .15,
      width: SizeConfig.screenWidth,
      child: _usersGroupsToggles(),
    );
  }

  FutureBuilder _usersGroupsToggles() {
    return FutureBuilder<List<Group>>(
        future:
            useProvider(prayerControllerProvider).fetchGroupsForCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<List<Group>> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return PPCToggleWidget(
                      title: StringConstants.prayerPals,
                      size: 2.5,
                      toggleState: _shareGlobal,
                      callback: (value) {
                        _shareGlobal = value;
                      },
                    );
                  }
                  final group = snapshot.data![index - 1];

                  return PPCToggleWidget(
                    title: group.groupName,
                    size: 2.5,
                    toggleState: _groupsToShareTo!.value.contains(
                      group.groupUID,
                    ),
                    callback: (value) {
                      if (prayer != null) {
                        //editing
                        if (_groupsToShareTo!.value.contains(group.groupUID)) {
                          // add to delete
                          if (!_groupsToRemovePrayerFrom!.value
                              .contains(group.groupUID)) {
                            _groupsToRemovePrayerFrom!.value
                                .add(group.groupUID);
                          }
                          if (!_groupsToShareTo!.value
                              .contains(group.groupUID)) {
                            _groupsForUpdateToAddTo!.value
                                .remove(group.groupUID);
                          }
                        } else {
                          if (!_groupsToShareTo!.value
                              .contains(group.groupUID)) {
                            _groupsForUpdateToAddTo!.value.add(group.groupUID);
                          }
                          if (_groupsToRemovePrayerFrom!.value
                              .contains(group.groupUID)) {
                            _groupsToRemovePrayerFrom!.value
                                .remove(group.groupUID);
                          }
                        }
                      } else {
                        _groupsToShareTo!.value.add(group.groupUID);
                      }
                    },
                  );
                });
          }
        });
  }

  Widget _buttonSection(_backButton) {
    return Column(
      children: [
        Consumer(builder: (ctx, ref, wid) {
          return Visibility(
            visible: prayer != null,
            child: PPCRoundedButton(
              title: StringConstants.answered,
              buttonRatio: .8,
              buttonWidthRatio: .8,
              callback: () {
                _updateAnsweredPrayer(ctx, prayer);
              },
              bgColor: Colors.lightBlueAccent.shade100,
              textColor: Colors.white,
            ),
          );
        }),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 2,
        ),
        Consumer(builder: (ctx, ref, widget) {
          return PPCRoundedButton(
            title: StringConstants.saveChanges,
            buttonRatio: .8,
            buttonWidthRatio: .8,
            callback: () {
              if (prayer != null)
                _updatePrayer(ctx, prayer);
              else
                _createPrayer(ctx);
            },
            bgColor: Colors.lightBlueAccent.shade100,
            textColor: Colors.white,
          );
        })
      ],
    );
  }

  _createPrayer(BuildContext ctx) async {
    final userUID = ctx.read(firebaseAuthProvider).currentUser!.uid;
    final srvMsg = await ctx.read(prayerControllerProvider).createPrayer(
        _titleController!.text,
        _detailsController!.text,
        userUID,
        _groupsToShareTo!.value,
        _shareGlobal);
    if (srvMsg == StringConstants.success) {
      ctx.read(homeControllerProvider).setIndex(1);
    } else {
      showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
    }
  }

  _updatePrayer(BuildContext ctx, prayer) async {
    final prayerType = PrayerType.MyPrayers;
    if (_groupsToRemovePrayerFrom != null) {
      for (var groupUid in _groupsToRemovePrayerFrom!.value) {
        if (_groupsToShareTo!.value.contains(groupUid)) {
          _groupsToShareTo!.value.remove(groupUid);
        }
      }
    }

    if (_groupsForUpdateToAddTo != null) {
      for (var groupUid in _groupsForUpdateToAddTo!.value) {
        if (!_groupsToShareTo!.value.contains(groupUid)) {
          _groupsToShareTo!.value.add(groupUid);
        }
      }
    }

    final srvMsg = await ctx.read(prayerControllerProvider).updatePrayer(
        prayerType,
        prayer.uid,
        _titleController!.text,
        _detailsController!.text,
        prayer.creatorUID,
        prayer.creatorDisplayName,
        prayer.dateCreated,
        _groupsToShareTo!.value,
        _groupsForUpdateToAddTo!.value,
        _groupsToRemovePrayerFrom!.value,
        _shareGlobal);
    if (srvMsg == StringConstants.success) {
      ctx.read(homeControllerProvider).setIndex(0);
      Navigator.of(ctx).pop();
    } else {
      showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
    }
  }

  _updateAnsweredPrayer(BuildContext ctx, prayer) async {
    final prayerType = PrayerType.Answered;
    final srvMsg = await ctx.read(prayerControllerProvider).updatePrayer(
        prayerType,
        prayer.uid,
        _titleController!.text,
        _detailsController!.text,
        prayer.creatorUID,
        prayer.creatorDisplayName,
        prayer.dateCreated,
        _groupsToShareTo!.value,
        _groupsForUpdateToAddTo!.value,
        _groupsToRemovePrayerFrom!.value,
        _shareGlobal);
    print(srvMsg);
    if (srvMsg == StringConstants.success) {
      ctx.read(homeControllerProvider).setIndex(0);
      Navigator.of(ctx).pop();
    } else {
      showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
    }
  }
}
