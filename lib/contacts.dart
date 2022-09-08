

import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             ListTile(
                
                title: Text('This page will be our edge in case if we are awarded, we plan to add  the following advanced FEATURES:',
            style: TextStyle(fontWeight: FontWeight.bold, 
            fontSize: 18))),
            
             ListTile(
                
                title: Text('1- Aritificial Intelligence  scan to paper busines cards, Auto Extract of Persoinal Information',
            style: TextStyle(fontWeight: FontWeight.bold, 
            fontSize: 18))),
            

            ListTile(
                
                title: Text('2- Save contacts to both cloud and mobile',
            style: TextStyle(fontWeight: FontWeight.bold, 
            fontSize: 18))),
            
            ListTile(
                
                title: Text('3- Search for contact person using Location you met him and date, in addition to other typical search ',
            style: TextStyle(fontWeight: FontWeight.bold, 
            fontSize: 18))),
            
            
          ],
        ),
      )
    );
  }
}