import 'dart:async';
import 'dart:math';

class ContactData {
  final int id;
  String name;
  String surname;
  String company;
  String handle;
  final String iconName;
  String bio;
  String mobile;
  bool isFavorite;

  ContactData(this.id, this.name, this.surname, this.company, this.iconName,
      this.handle, this.bio, this.mobile, this.isFavorite);
}

class ContactsBloc {
  Map<int, ContactData> _contacts;

  Map<int, ContactData> get getContacts => _contacts;

  final _contactsController = StreamController<Map<int, ContactData>>();
  StreamController _actionController = StreamController();

  ContactsBloc() {
    generateExampleUserData();
    _actionController.stream.listen(_updateContactsList);
  }

  Stream<Map<int, ContactData>> get contactsStream =>
      _contactsController.stream;

  Map<int, ContactData> generateExampleUserData() {
    var map = Map<int, ContactData>.identity();

    List<ContactData>.generate(50, (index) {
      var name = namesPool[Random().nextInt(namesPool.length)];
      var surname = surnamesPool[Random().nextInt(surnamesPool.length)];
      return ContactData(
          index,
          name,
          surname,
          companiesPool[Random().nextInt(companiesPool.length)],
          photosPool[Random().nextInt(photosPool.length)],
          "@${name.toLowerCase()}_${surname.toLowerCase()[0]}",
          "",
          "+380955626888",
          Random().nextInt(3) == 1);
    }).forEach((element) {
      map[element.id] = element;
    });

    _contacts = map;
    _contactsController.sink.add(_contacts);
  }

  updateContact(ContactData value) {
    getContacts[value.id] = value;
    _contactsController.sink.add(_contacts);
  }

  _updateContactsList(data) {
    print("UPDATE?");
    _contactsController.sink.add(_contacts);
  }

  void dispose() {
    _actionController.close();
    _contactsController.close();
  }


// void updateUserById(int id, ContactData data) {
//   if (map.containsKey(id)) {
//     map[id] = data;
//   }
// }
}

var namesPool = [
  'Vlad',
  'Alex',
  'Andrey',
  'Yuri',
  'Dora',
  'John',
  'Vitaliy',
  'Joshua',
  'Sam',
  'Megan',
  'Joel',
  'Kyle',
  'Lauren'
];

var surnamesPool = [
  'Smith',
  'Jones',
  'Williams',
  'Brown',
  'Taylor',
  'Davies',
  'Evans',
  'Thomas',
  'Johnson',
  'Lee',
  'Walker',
  'Wright',
  'Thompson',
  'White',
  'Hughes',
  'Edwards',
  'Agnew',
  'Allison',
  'Barnard',
  'Blakely',
  'Cannon',
  'Dickenson',
  'Davis',
];

var companiesPool = [
  'Stanford University',
  'Hooli Inc.',
  'UC Berkeley',
  'Husky Energy',
  'CAT',
  'Pied Piper',
  'Hollywood',
  'Valve',
  'Alphabet',
  'Apple',
  'Amazon',
];

var photosPool = [
  'photo1.jpg',
  'photo2.jpg',
  'photo3.jpg',
  'photo4.jpg',
  'photo5.jpg',
  'photo6.jpg',
];
