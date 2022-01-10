import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/auth/facebook_sign_in.dart';
import 'package:firebase_demo/auth/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  _ContactsListPageState createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late List<DocumentSnapshot> documents;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    print(user.displayName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                // final provider =
                // Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.logout();
                FacebookSignInProvider().facebookLogOut();
              },
              child: Text('Logout'))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestoreDatabase.collection('contacts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              documents = snapshot.data!.docs;
              return buildContactList();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEditContactDialog(context, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildContactList() {
    return ListView(
        children: documents.map((doc) {
      return Dismissible(
          key: Key(doc['mobileNo']),
          onDismissed: (direction) {
            deleteContact(doc.id);
          },
          child: InkWell(
            onTap: () {
              addEditContactDialog(context, doc);
            },
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                      child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 3.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            doc['firstName'][0].toString().toUpperCase() +
                                doc['lastName'][0].toString().toUpperCase(),
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${doc['firstName']} ${doc['lastName']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.call,
                                      size: 15, color: Colors.black),
                                  SizedBox(width: 5),
                                  Text(doc['mobileNo'])
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 15, color: Colors.amber),
                                  SizedBox(width: 5),
                                  Text(doc['email'])
                                ],
                              )
                            ],
                          ))
                    ],
                  ))),
            ),
          ));
    }).toList());
  }

  void createContact(String? firstName, String? lastName, String? mobileNo,
      String? email) async {
    await firestoreDatabase.collection('contacts').add({
      'firstName': firstName,
      'lastName': lastName,
      'mobileNo': mobileNo,
      'email': email
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Contact created!!!')));
  }

  void updateContact(String docId, String firstName, String lastName,
      String mobileNo, String email) {
    try {
      firestoreDatabase.collection('contacts').doc(docId).update({
        'firstName': firstName,
        'lastName': lastName,
        'mobileNo': mobileNo,
        'email': email
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Contact updated..!!')));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void deleteContact(String docId) {
    try {
      firestoreDatabase.collection('contacts').doc(docId).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('contact deleted..!!')));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  addEditContactDialog(BuildContext context, DocumentSnapshot? doc) async {
    if (doc != null) {
      firstNameController.text = doc['firstName'];
      lastNameController.text = doc['lastName'];
      mobileNoController.text = doc['mobileNo'];
      emailController.text = doc['email'];
    } else {
      firstNameController.text = "";
      lastNameController.text = "";
      mobileNoController.text = "";
      emailController.text = "";
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(doc != null ? 'Edit Contact' : 'Add Contact'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextField(
                    controller: firstNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    )),
                SizedBox(height: 10),
                TextField(
                    controller: lastNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: mobileNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Mobile No',
                    )),
                SizedBox(height: 10),
                TextField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    )),
                SizedBox(
                  height: 10,
                )
              ]),
            ),
            actions: [
              new TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    if (doc != null) {
                      updateContact(
                          doc.id,
                          firstNameController.text,
                          lastNameController.text,
                          mobileNoController.text,
                          emailController.text);
                    } else {
                      createContact(
                          firstNameController.text,
                          lastNameController.text,
                          mobileNoController.text,
                          emailController.text);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          );
        });
  }
}
