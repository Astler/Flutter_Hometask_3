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

  ContactData(this.id, this.name, this.surname, this.company, this.iconName, this.handle, this.bio, this.mobile,
      this.isFavorite);
}

var contactsDataStatic = List<ContactData>.empty(growable: true);

var map = Map<int, ContactData>.identity();

class ContactsDataModel {
  List<ContactData> getContacts() {
    if (map.isEmpty) {
      var contactsData = List<ContactData>.empty(growable: true);

      contactsData = List<ContactData>.generate(50, (index) {
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
      });

      contactsData.forEach((element) {
        map[element.id] = element;
      });
    }

    return map.values.toList();
  }

  Map<int, ContactData> getUsersMap() {
    return map;
  }

  void updateUserById(int id, ContactData data) {
    if (map.containsKey(id)) {
      map[id] = data;
    }
  }
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
