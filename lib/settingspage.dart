import 'package:bcapp/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsW extends StatefulWidget {
  SettingsW({Key? key}) : super(key: key);

  @override
  State<SettingsW> createState() => _SettingsWState();
}

class _SettingsWState extends State<SettingsW> {
  bool LangisEng = true;
  List<bool> _selections = [
    (localLang == "en") ? true : false,
    (localLang == "en") ? false : true
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ToggleButtons(
                    children: <Widget>[
                      Text('English'),
                      Text('عربي'),
                    ],
                    isSelected: _selections,
                    onPressed: (int index) {
                      if (index == 0) {
                        localLang = 'en';
                      } else {
                        localLang = 'ar';
                      }
                      setState(() {
                        for (int i = 0; i < _selections.length; i++) {
                          _selections[i] = i == index;
                        }
                        //_selections[index] = !_selections[index];
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Show Picture')
                ,Switch(
                value: ppisvisible,
                onChanged: (value) {
                  setState(() {
                    ppisvisible = value;
                  });
                },
          ),
              ],
            ),
            SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: (() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => loginWidget()),
                  ),
                );
                FirebaseAuth.instance.signOut();
              }),
              child: Text('Sign Out')),
        ],
      ),
    );
  }
}
