import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lunch_app/resources/add_data.dart';
import 'package:lunch_app/resources/edit_view_page.dart';
import 'package:lunch_app/resources/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final User? user;

  NavigationDrawerWidget(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  Uint8List? _image;

  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   _image = img;

  //   String resp = await StoreData().saveData(
  //     file: _image!,
  //     email: widget.user!.email!,
  //   );
  //   setState(() {
  //     _image = img;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            accountName: Text(
              'Easy Cloud',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              widget.user!.email!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              //radius: 68,

              backgroundImage: _image != null ? MemoryImage(_image!) : null,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProfilePage(user: widget.user),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.corporate_fare),
            title: Text('Powered By'),
            trailing: Text(
              'Easy Cloud',
              style: TextStyle(
                color: Color.fromARGB(255, 136, 135, 133),
              ),
            ),
            onTap: () async {
              await launch('https://easycloud.in/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Rate Us'),
            trailing: Text(
              'OpenPlayStore',
              style: TextStyle(
                color: Color.fromARGB(255, 136, 135, 133),
              ),
            ),
            onTap: () async {
              await launch(
                  'https://play.google.com/store/apps/details?id=in.easycloud.mealmaven&pli=1');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Color.fromARGB(255, 1, 0, 0),
              ),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
