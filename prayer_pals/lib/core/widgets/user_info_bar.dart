import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/ppcuser_core_provider.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/user/view/edit_profile.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'avatar_widget.dart';

class UserInfoBarWidget extends HookWidget {
  final bool isSettings;

  const UserInfoBarWidget({
    Key? key,
    required this.isSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ppcUser = useProvider(ppcUserCoreProvider).getCurrentUserModel();
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: PPCAvatar(
                    radSize: 25,
                    image: _image,
                    networkImage: ppcUser!.imageURL,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 3,
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    ppcUser.username,
                    style: TextStyle(
                      height: SizeConfig.safeBlockVertical! * .2,
                      fontSize: SizeConfig.safeBlockVertical! * 3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Visibility(
                      visible: isSettings,
                      child: InkWell(
                          child: const Icon(Icons.edit),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage()));
                          })),
                )
              ]),
          const SizedBox(height: 10),
          PPCstuff.divider,
        ],
      ),
    );
  }
}
