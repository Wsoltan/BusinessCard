// ignore_for_file: prefer_const_constructors

import 'package:bcapp/locale/local_controller.dart';
import 'package:bcapp/main.dart';
import 'package:flutter/material.dart';
import 'package:bcapp/cls/bccls.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:get/get.dart';

import 'package:bcapp/ViewCardsPage.dart';
import 'package:bcapp/locale/local_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'locale/locale.dart';

class BCWLS extends StatelessWidget {
  final UnitCard _unitCard;
  BCWLS(this._unitCard);
  setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation != null) {
      setLandscapeOrientation();
    }
    return Material(
      child: Container(
          color: Colors.white,
          //height: 100,
          //color: Colors.transparent,
          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                //color: Colors.transparent,
                border: Border.all(color: Colors.grey, width: 2.0),
          
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  //Row 1 =================================================================
                  Row(
                    children: [
                      //================ Start of Personal Picture Box
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            //topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            //bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        height: (MediaQuery.of(context).size.height - 46) * 0.35,
                        width: (MediaQuery.of(context).size.width - 26) * 0.22,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            child: Image.network('${_unitCard.ppURL}'),
                          ),
                        ),
                      ),
                      //================ End of Personal Picture Box
                      //------------------------------------------------------------------------
                      //================ Start of Personal Details Box
                      Container(
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.green, width: 1.0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        //height:(MediaQuery.of(context).size.height - 46) * 0.35,
                        width: (MediaQuery.of(context).size.width - 26) * 0.50,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${_unitCard.FName} ${_unitCard.LName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${_unitCard.Role}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${_unitCard.Dep}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      //================ End of Personal Details Box
                      //----------------------------------------------------------------------------
                      //================ Start of Company Logo Box
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.cyan, width: 2.0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        height: (MediaQuery.of(context).size.height - 46) * 0.35,
                        width: (MediaQuery.of(context).size.width - 26) * 0.25,
                        child: Image.asset('images/${_unitCard.Company}_QR_logo.jpeg'),
                      ),
                      //================ End of Company Logo Box
                    ],
                  ),
                  //------------------------------------------------------------------------
                  //-----------------------------------------------------------------------
                  //Row 2==================================================================
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.red, width: 2.0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        height: (MediaQuery.of(context).size.height - 46) * 0.55,
                        width: (MediaQuery.of(context).size.width - 26) * 0.60,
                        child: ListView(
                          children: [
                            ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: FaIcon(FontAwesomeIcons.envelope),
                              title: Text('${_unitCard.Email}'),
                            ),
                            ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: FaIcon(FontAwesomeIcons.phone),
                              title: Text(
                                  "${_unitCard.LandLineNo}    Ext.:${_unitCard.Ext},"),
                            ),
                            ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: FaIcon(FontAwesomeIcons.mobile),
                              title: Text("${_unitCard.Mobile},"),
                            ),
                            ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: FaIcon(FontAwesomeIcons.weebly),
                              title: Text("${_unitCard.WebPageURL}"),
                            ),
                          ],
                        ),
                      ),
                      //============================== Start of QR Code Image Box
                      SingleChildScrollView(
                        child: Container(
                          height: (MediaQuery.of(context).size.height - 46) * 0.55,
                          width: (MediaQuery.of(context).size.width - 26) * 0.40,
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    final directory =
                                        await getApplicationDocumentsDirectory();
                                    final path = directory.path;
                      
                                    var pathAsText =
                                        "$path/${_unitCard.Company}_vcf.vcf";
                      
                                    var contactAsFile = File(pathAsText);
                                    contactAsFile.writeAsString(
                                        _unitCard.getFullVC().getFormattedString());
                      
                                    // var vcf = contactAsFile.renameSync(
                                    //contactAsFile.path.replaceAll(".txt", ".vcf"));
                      
                                    Share.shareFiles([pathAsText],
                                        subject:
                                            'Hi this me: ${_unitCard.FName}  ${_unitCard.LName} from ${_unitCard.Company}',
                                        text:
                                            'It was pleasure to meet you. Please add my contacts. Wish to hear from you soon.');
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: QrImage(
                                  data: _unitCard.getVC().getFormattedString(),
                      
                                  foregroundColor: Colors.grey,
                      
                                  version: QrVersions.auto,
                                  embeddedImage: AssetImage(
                                      'images/${_unitCard.Company}_QR_logo.jpeg'),
                                  embeddedImageStyle:
                                      QrEmbeddedImageStyle(size: Size(50, 25)),
                      
                                  //errorCorrectionLevel: QrErrorCorrectLevel.H ,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //============================== End of QR Code Image Box
                    ],
                  ),
                  //Row 3 ==============================================================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.red, width: 2.0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        height: (MediaQuery.of(context).size.height - 46) * 0.10,
                        width: (MediaQuery.of(context).size.width - 26) * 0.67,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.facebook),
                              iconSize: 25,
                              color: Colors.blue,
                              onPressed: () async {
                                final url = '${_unitCard.fbLink}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.youtube),
                              iconSize: 25,
                              color: Colors.blue,
                              onPressed: () async {
                                final url = '${_unitCard.youtubeLink}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.instagram),
                              iconSize: 25,
                              color: Colors.blue,
                              onPressed: () async {
                                final url = '${_unitCard.instaLink}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.twitter),
                              iconSize: 25,
                              color: Colors.blue,
                              onPressed: () async {
                                final url = '${_unitCard.twitterLink}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.linkedin),
                              iconSize: 25,
                              color: Colors.blue,
                              onPressed: () async {
                                final url = '${_unitCard.lnkdnLink}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            IconButton(
                                icon: FaIcon(FontAwesomeIcons.minimize),
                                iconSize: 25,
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => ViewCardsList()),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      /* Container(
                       decoration: BoxDecoration(
                              //border: Border.all(color: Colors.cyan, width: 2.0),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(0.0),
                                bottomRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(0.0),
                              ),
                            ),
                            height:
                                (MediaQuery.of(context).size.height - 46) * 0.10,
                            width:
                                (MediaQuery.of(context).size.width - 26) * 0.33,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ElevatedButton(onPressed: (){}, child: Text('Share Me'))
                        ),
                      ), */
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
