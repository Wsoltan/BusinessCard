
import 'package:bcapp/locale/local_controller.dart';
import 'package:bcapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cls/bccls.dart';
import 'bcw.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bcapp/main.dart';

class CardsListW extends StatefulWidget {
  CardsListW({Key? key}) : super(key: key);

  @override
  State<CardsListW> createState() => _CardsListWState();
}

class _CardsListWState extends State<CardsListW> {
  List<Object> _cards = [];

  String _profileImgURL = '';

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCards();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (BuildContext context, int index) {
          return BCWUnit(_cards[index] as UnitCard);
        },
          ),
      );
  }

  
  Future getCards() async {
    final _userID = FirebaseAuth.instance.currentUser!.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc('qymSFSYHlhR6IfIAWglTL5lLcZT2')
        .collection('cards')
        .orderBy('order', descending: false)
        .get();

    Reference ref =
        FirebaseStorage.instance.ref().child("usesrs_images/${_userID}_PP.png");

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
  }
}