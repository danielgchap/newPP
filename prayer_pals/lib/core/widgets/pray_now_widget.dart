import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/size_config.dart';

class PrayNowRow extends StatefulWidget {
  final String title;
  final String description;
  bool isSelected;
  final VoidCallback callback;

  PrayNowRow({
    Key? key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.callback,
  }) : super(key: key);

  @override
  _PrayNowRowState createState() => _PrayNowRowState();
}

class _PrayNowRowState extends State<PrayNowRow> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.blue),
      child: CheckboxListTile(
        value: widget.isSelected,
        onChanged: (value) {
          setState(() {
            widget.isSelected = !widget.isSelected;
            widget.callback();
            if (widget.isSelected == true) {
              showDialog(
                  builder: (BuildContext context) => _showDescription(
                      context, widget.title, widget.description),
                  context: context);
            }
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockVertical! * 3.5,
            fontFamily: 'Helvetica',
            color: Colors.lightBlue,
          ),
        ),
        activeColor: Colors.lightBlue,
        checkColor: Colors.white,
      ),
    );
  }

  Widget _showDescription(BuildContext context, _title, _description) {
    return new AlertDialog(
      title: Text(
        _title,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        // action button
        IconButton(
          icon: Icon(
            Icons.close,
            size: SizeConfig.safeBlockHorizontal! * 8,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }, //Change to Answered prayer
        ),
      ],
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _description,
            style: TextStyle(
              fontFamily: 'Helvetica',
            ),
          )
        ],
      ),
    );
  }
}
