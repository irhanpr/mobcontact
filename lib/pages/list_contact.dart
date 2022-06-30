import 'package:flutter/material.dart';
import 'package:mobcontact/database/db_helper.dart';
import 'package:mobcontact/models/contact_model.dart';

class ListContact extends StatefulWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  final List<Contact> listContact = [];
  final DbHelper dbHelper = DbHelper();
  final List<Contact> sampleData = [
    Contact(
        id: 1,
        name: 'Luhut Binsar Panjaitan',
        mobileNo: '0812313334',
        email: 'loehoet@gmail.com',
        company: 'PT. ABC',
        photo: ''),
    Contact(
        id: 2,
        name: 'Triwahyuni',
        mobileNo: '081145323',
        email: 'triwahyuni23jan@gmail.com',
        company: 'PT. DEF',
        photo: ''),
  ];

  Future<void> getAllContact() async {
    listContact.clear();
    await dbHelper.getListContact().then((value) {
      (value as List).forEach((json) {
        listContact.add(Contact.fromJson(json));
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Contacts")),
      body: ListView.builder(
          itemCount: listContact.length,
          itemBuilder: (context, index) {
            Contact contact = listContact[index];
            return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.amber,
                ),
                title: Text("${contact.name}"),
                subtitle: Text("${contact.email}, ${contact.mobileNo}"),
                trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await dbHelper.delete(contact.id!);
                              getAllContact();
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    )));
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () async {
              sampleData.forEach((data) {
                dbHelper.save(data).then((value) {});
              });
              getAllContact();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () async {
              getAllContact();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
