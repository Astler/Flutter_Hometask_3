import 'package:flutter/material.dart';

import 'contact_info_screen.dart';
import 'contacts_data.dart';
import 'list_items.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW3',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'HW3 Contacts List'),
        ContactInfoScreen.routeName: (context) => ContactInfoScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _rawList = ContactsDataModel().getContacts();

  List<ListItem> getSortedList() {
    var _newRawList = List<ListItem>.empty(growable: true);

    _rawList.sort((a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));

    var firstLetter = _rawList.first.surname[0].toLowerCase();

    var _byLetterArray = List<ContactData>.empty(growable: true);

    for (var contactData in _rawList) {
      var contactFirstLetter = contactData.surname[0].toLowerCase();

      if (firstLetter != contactFirstLetter || _rawList.last == contactData) {
        if (firstLetter != contactFirstLetter) {
          _newRawList.add(HeaderItem(firstLetter.toUpperCase()));
          firstLetter = contactFirstLetter;
        } else {
          _newRawList.add(HeaderItem(contactFirstLetter.toUpperCase()));
          _byLetterArray.add(contactData);
        }

        _byLetterArray
            .sort((first, second) => first.name.toLowerCase().compareTo(second.name.toLowerCase()));

        _byLetterArray.forEach((element) {
          _newRawList.add(ContactItem(element));
        });

        _byLetterArray.clear();
      }

      _byLetterArray.add(contactData);
    }

    return _newRawList;
  }

  var sortedList = List.empty(growable: true);

  void _reloadList() {
    setState(() {
      sortedList = getSortedList();
    });
  }

  _navigateUpdateData(BuildContext context, ContactData item) async {
    await Navigator.pushNamed(
      context,
      ContactInfoScreen.routeName,
      arguments: ContactInfoArguments(
        item.id,
      ),
    );

    _reloadList();
  }

  @override
  Widget build(BuildContext context) {
    sortedList = getSortedList();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: sortedList.length,
                  itemBuilder: (_, index) {
                    final item = sortedList[index];

                    return GestureDetector(
                      onTap: () => {
                        if (item is ContactItem)
                          {
                            _navigateUpdateData(context, item.data)
                          },
                      },
                      child: ListTile(
                        title: item.buildTitle(context),
                        subtitle: item.buildSubtitle(context),
                        leading: item.buildIcon(
                            context,
                            () => {
                                  if (item is ContactItem)
                                    {
                                      item.data.isFavorite =
                                          !item.data.isFavorite
                                    },
                                  _reloadList()
                                }), //Icon(Icons.star_border, color: Colors.blue),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
