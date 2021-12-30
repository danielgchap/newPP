import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/ppcuser_core_provider.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/features/home/models/scripture_list.dart';
import 'package:prayer_pals/features/home/providers/home_provider.dart';
import 'package:prayer_pals/core/utils/constants.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);
  final welcome = 'Welcome'; // Change variable based on time of day TODO;
  @override
  Widget build(BuildContext context) {
    final ppCoreProvider = useProvider(ppcUserCoreProvider);
    useEffect(() {
      ppCoreProvider.setupPPUserListener();
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          StringConstants.home,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 4,
              ),
              Text(
                welcome,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: SizeConfig.safeBlockVertical! * 8.5,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 1.5,
              ),
              const Divider(),
              Card(
                  elevation: 5,
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  color: Colors.lightBlue[50],
                  //shadowColor: Colors.black87,
                  child: _scriptureSection(context)),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 6,
              ),
              _buttonsSection(context),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scriptureSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal! * 8,
      ),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
          /*   Consumer(
            builder: (context, ref, _) {
              Scripture scripture =
                  context.read(homeControllerProvider).fetchDailyScripture();
              return Column(
                children: [
                  Text(
                    scripture.verse,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: SizeConfig.safeBlockVertical! * 2.5,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  Text(
                    scripture.ref,
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: SizeConfig.safeBlockVertical! * 3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          )
          */
          const GetScripture(),
        ],
      ),
    );
  }

  Widget _buttonsSection(BuildContext context) {
    return Column(
      children: [
        PPCRoundedButton(
          title: StringConstants.addPrayer,
          buttonRatio: 1,
          buttonWidthRatio: 1,
          callback: () {
            context.read(homeControllerProvider).setIndex(2);
          },
          bgColor: Colors.lightBlueAccent.shade100,
          textColor: Colors.white,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 2,
        ),
        PPCRoundedButton(
          title: StringConstants.prayNow,
          buttonRatio: 1,
          buttonWidthRatio: 1,
          callback: () {
            Navigator.pushNamed(context, '/PrayNowPage');
          },
          bgColor: Colors.lightBlueAccent.shade100,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
