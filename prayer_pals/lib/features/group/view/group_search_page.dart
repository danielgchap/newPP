import 'package:flutter/material.dart';
import 'package:prayer_pals/features/group/view/search_groups_widget.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/utils/constants.dart';

//////////////////////////////////////////////////////////////////////////
//
//     when a user clicks join group, they go here and can search for groups
//     to join. logic for returning the search results is in the application
//     files
//
//////////////////////////////////////////////////////////////////////////

class GroupSearchPage extends StatefulWidget {
  const GroupSearchPage({Key? key}) : super(key: key);

  @override
  _GroupSearchPageState createState() => _GroupSearchPageState();
}

class _GroupSearchPageState extends State<GroupSearchPage> {
  final TextEditingController _groupNameController = TextEditingController();
  bool showResults = false; // this is just temporary. The results should
  // be filtered and returned when button is pressed.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            StringConstants.joinGroup,
          ),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 3,
                      ),
                      controller: _groupNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringConstants.search,
                        hintStyle: TextStyle(
                          fontSize: SizeConfig.safeBlockVertical! * 3,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.lightBlue,
                        size: SizeConfig.safeBlockHorizontal! * 8,
                      ),
                      onPressed: () {
                        showResults = true;
                        //PPCSearchGroupsWidget(result: _groupNameController.text);
                        setState(() {});
                      },
                    ),
                  ),
                ]),
          ),
          PPCstuff.divider,
          showResults == true
              ? PPCSearchGroupsWidget(searchTerm: _groupNameController.text)
              : const Text(""), //Find a better way of doing this TODO
        ]));
  }
}
