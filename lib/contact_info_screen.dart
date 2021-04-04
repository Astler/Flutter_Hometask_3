import 'package:flutter/material.dart';

import 'contacts_data.dart';

class ContactInfoArguments {
  final int id;

  ContactInfoArguments(this.id);
}

class ContactInfoScreen extends StatefulWidget {
  static const routeName = '/contact_data';

  ContactInfoScreen({Key key}) : super(key: key);

  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final companyNameController = TextEditingController();
  final handleController = TextEditingController();
  final bioController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ContactInfoArguments args =
        ModalRoute.of(context).settings.arguments as ContactInfoArguments;

    final _nameKey = GlobalKey<FormFieldState>();
    final _surnameKey = GlobalKey<FormFieldState>();
    final _handleKey = GlobalKey<FormFieldState>();
    final _phoneKey = GlobalKey<FormFieldState>();
    final _bioKey = GlobalKey<FormFieldState>();

    if (args != null) {
      var dataModel = ContactsDataModel();

      var usersMap = dataModel.getUsersMap();

      var userId = args.id;
      ContactData userData = usersMap[userId];

      nameController.text = userData.name;
      surnameController.text = userData.surname;
      companyNameController.text = userData.company;
      handleController.text = userData.handle;
      bioController.text = userData.bio;
      mobileController.text = userData.mobile;

      return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              MaterialButton(
                textColor: Colors.white,
                onPressed: () {
                  if (!_nameKey.currentState.validate() ||
                      !_handleKey.currentState.validate() ||
                      !_surnameKey.currentState.validate() ||
                      !_bioKey.currentState.validate() ||
                      !_phoneKey.currentState.validate()) {
                    return;
                  }

                  userData.name = nameController.text;
                  userData.surname = surnameController.text;
                  userData.company = companyNameController.text;
                  userData.handle = handleController.text;
                  userData.mobile = mobileController.text;
                  userData.bio = bioController.text;
                  dataModel.updateUserById(userId, userData);
                  Navigator.pop(context);
                },
                child: Text("Save"),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40, bottom: 16),
                  width: 150.0,
                  height: 150.0,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    image: new DecorationImage(
                      image: AssetImage(userData?.iconName),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(100.0)),
                    border: new Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                  ),
                ),
              ),
              SimpleEditFieldWidget(
                editKey: _nameKey,
                controller: nameController,
                upperText: 'Name ',
                hintText: "Contact name",
                isImportant: true,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name can\'t be empty!';
                  }

                  if (value.length > 70) {
                    return 'Max name length is 70 letters!';
                  }

                  return null;
                },
              ),
              SimpleEditFieldWidget(
                editKey: _surnameKey,
                controller: surnameController,
                upperText: 'Surname ',
                hintText: "Contact surname",
                isImportant: true,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Surname can\'t be empty!';
                  }

                  if (value.length > 70) {
                    return 'Max name length is 70 letters!';
                  }

                  return null;
                },
              ),
              SimpleEditFieldWidget(
                editKey: _handleKey,
                controller: handleController,
                upperText: 'Profile handle ',
                hintText: "Contact handle",
                isImportant: true,
                exampleText:
                    "example:${nameController.text.toLowerCase()}_${surnameController.text.toLowerCase()}",
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Handle can\'t be empty!';
                  }

                  if (value == "@") {
                    return 'Incorrect handle: @!';
                  }

                  if (value[0] != "@") {
                    return 'Handle should start with @!';
                  }

                  return null;
                },
              ),
              SimpleEditFieldWidget(
                editKey: _phoneKey,
                controller: mobileController,
                upperText: 'Mobile ',
                hintText: "Contact mobile",
                isImportant: false,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number can\'t be empty!';
                  }

                  if (!value.startsWith("+38")) {
                    return 'You should input phone number in format: +38XXXXXXXXXX';
                  }

                  if (value.length != 13) {
                    return 'Incorrect phone number. Did you miss something?';
                  }

                  return null;
                },
              ),
              SimpleEditFieldWidget(
                  controller: companyNameController,
                  upperText: 'Company ',
                  hintText: "Contact company",
                  isImportant: false),
              SimpleEditFieldWidget(
                editKey: _bioKey,
                controller: bioController,
                upperText: 'Bio ',
                hintText: "Contact bio",
                isImportant: false,
                exampleText: "maximum of 110 letters",
                multilineText: true,
                validation: (value) {
                  if (value.length > 110) {
                    return 'Bio name length is 110 letters!';
                  }

                  return null;
                },
              ),
              Container(margin: EdgeInsets.all(32))
            ]),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Id is null"),
        ),
      );
    }
  }
}

class SimpleEditFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String upperText;
  final String hintText;
  final String exampleText;
  final bool isImportant;
  final bool multilineText;
  final FormFieldValidator<String> validation;
  final Key editKey;

  const SimpleEditFieldWidget(
      {Key key,
      this.controller,
      this.upperText,
      this.hintText,
      this.isImportant,
      this.exampleText = "",
      this.multilineText = false,
      this.validation,
      this.editKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            new Flexible(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                padding:
                    EdgeInsets.only(left: 32, right: 32, bottom: 8, top: 16),
                child: RichText(
                  textWidthBasis: TextWidthBasis.longestLine,
                  text: TextSpan(
                    text: upperText,
                    style: TextStyle(color: Colors.grey),
                    children: <TextSpan>[
                      if (isImportant)
                        TextSpan(
                            text: '*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              flex: 1,
            ),
            if (exampleText != null)
              Flexible(
                child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    padding: EdgeInsets.only(
                        left: 32, right: 32, bottom: 8, top: 16),
                    child: Text(exampleText,
                        style: TextStyle(color: Colors.grey))),
                flex: 1,
              )
          ],
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.only(left: 32, right: 32),
          child: TextFormField(
            key: editKey,
            keyboardType: multilineText ? TextInputType.multiline : null,
            maxLines: multilineText ? null : 1,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                ),
              ),
            ),
            validator: validation,
          ),
        ),
      ],
    );
  }
}
