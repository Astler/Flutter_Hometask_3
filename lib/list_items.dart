import 'package:flutter/material.dart';

import 'contacts_data.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);

  Widget buildIcon(BuildContext context, GestureTapCallback onTap);
}

class HeaderItem implements ListItem {
  final String heading;

  HeaderItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          heading,
          style: TextStyle(
            fontSize: 20,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  @override
  Widget buildSubtitle(BuildContext context) => null;
  @override
  Widget buildIcon(BuildContext context, onTap) => null;
}

class ContactItem implements ListItem {
  final ContactData data;

  ContactItem(this.data);

  @override
  Widget buildTitle(BuildContext context) =>
      Text(data.name + " " + data.surname);

  Widget buildSubtitle(BuildContext context) {
    if (data.company.isNotEmpty) {
      return Text(data.company);
    }

    return null;
  }

  @override
  Widget buildIcon(BuildContext context, GestureTapCallback onTap) {
    return Wrap(
      spacing: 12, // space between two icons
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0)),
            height: 40.0,
            width: 25.0,
            alignment: AlignmentDirectional.center,
            child: data.isFavorite
                ? Icon(Icons.star, color: Colors.blue[400])
                : null, //Icon(Icons.star_border, color: Colors.blue),
          ),
        ),
        ClipOval(
          child: Image.asset(
            data.iconName,
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          ),
        ), // icon-2
      ],
    );
  }
}
