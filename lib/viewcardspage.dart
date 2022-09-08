import 'dart:async';

import 'package:bcapp/contacts.dart';
import 'package:bcapp/locale/local_controller.dart';
import 'package:bcapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'cls/bccls.dart';
import 'bcw.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bcapp/main.dart';
import 'package:bcapp/cardslistpage.dart';
import 'package:bcapp/settingspage.dart';


class ViewCardsList extends StatefulWidget {
  ViewCardsList({Key? key}) : super(key: key);

  @override
  State<ViewCardsList> createState() => _ViewCardsListState();
}

class _ViewCardsListState extends State<ViewCardsList> {
  List<Object> _cards = [];

  String _profileImgURL = '';

  int currentPageIndex= 0;

  final _Pages = [CardsListW(), ContactsPage(),SettingsW()];

  

 /*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCards();
  } */

  @override
  Widget build(BuildContext context) {
    var currentPage;
    MyLocaleController ctrlLang = Get.find();
    List<bool> isSelected = [true, false];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards List'.tr),
      ),
      body: _Pages[currentPageIndex],/* SafeArea(
        child: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (BuildContext context, int index) {
          return BCWUnit(_cards[index] as UnitCard);
        },
          ),
      ), */
      bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon:  Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon:  Icon(Icons.person), label: 'Contacts'),
      BottomNavigationBarItem(icon:  Icon(Icons.settings), label: 'Settings')
      ],
      onTap: (index)=> setState(() { this.currentPageIndex = index;},
      ),),
      
    );
  }
/* 
  Future getCards() async {
    //final _userID = FirebaseAuth.instance.currentUser!.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc('qymSFSYHlhR6IfIAWglTL5lLcZT2')
        .collection('cards')
        .orderBy('order', descending: false)
        .get();

    Reference ref =
        FirebaseStorage.instance.ref().child("usesrs_images/PP2.png");

    //get image url from firebase storage
    var url = await ref.getDownloadURL();

    //var codata = await FirebaseFirestore.instance.collection('fixedData').get();

    setState(() {
      //fill in _cards
      if (localLang == "ar") {
        _cards = List.from(
            data.docs.map((doc) => UnitCard.fromSanpshot_ar(doc, url)));
      } else {
        _cards =
            List.from(data.docs.map((doc) => UnitCard.fromSanpshot(doc, url)));
      }
    });
  } */
}
