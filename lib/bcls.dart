// ignore_for_file: prefer_const_constructors


import 'package:bcapp/main.dart';
import 'package:flutter/material.dart';
import 'package:bcapp/cls/bccls.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';


import 'package:bcapp/ViewCardsPage.dart';

import 'package:flutter/services.dart';



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

        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
            padding: const EdgeInsets.all(10.0),
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
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Row 1 =================================================================
                Container(height: (MediaQuery.of(context).size.height - 46) * 0.36 ,
                  child: Row(
                    children: [
                      //================ Start of Personal Picture Box
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            //topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(5.0),
                            //bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        /*  height: (MediaQuery.of(context).size.height - 46) * 0.34,
                        width: (MediaQuery.of(context).size.width - 26) * 0.22, */
                        child: Visibility(visible: ppisvisible,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              child: Image.network(
                                '${_unitCard.ppURL}',
                                fit: BoxFit.contain,
                                width: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //================ End of Personal Picture Box
                      //------------------------------------------------------------------------
                      //================ Start of Personal Details Box
                      Expanded(
                        child: Container(
                          //height:(MediaQuery.of(context).size.height - 46) * 0.35,
                          //width: (MediaQuery.of(context).size.width - 26) * 0.50,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ViewCardsList()),
                                ),
                              );
                            },
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
                        ),
                      ),
                      //================ End of Personal Details Box
                      //----------------------------------------------------------------------------
                      //================ Start of Company Logo Box
                      Container(
                        alignment: Alignment.centerRight,
                        /* height: (MediaQuery.of(context).size.height - 46) * 0.34,
                        width: (MediaQuery.of(context).size.width - 26) * 0.25, */
                        child: Image.asset(
                          'images/${_unitCard.Company}_QR_logo.jpeg',
                          fit: BoxFit.contain,
                          width: 200,
                        ),
                      ),
                      //================ End of Company Logo Box
                    ],
                  ),
                ),

                //Row 2==================================================================
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      //Start of Contacts==================================================================
                      Container(
                       /*  decoration: BoxDecoration(
                          //color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ), */
                        height:
                            (MediaQuery.of(context).size.height - 46) * 0.53,
                        width: (MediaQuery.of(context).size.width - 26) * 0.750,
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
                      //End of Contacts==================================================================
                      //============================== Start of QR Code Image Box
                      Container(
                        alignment: Alignment.centerRight,
                       /*  decoration: BoxDecoration(
                          //color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ), */
                        /*  height: (MediaQuery.of(context).size.height - 46) * 0.58,
                        width: (MediaQuery.of(context).size.width - 26) * 0.40, */
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final directory =
                                        await getApplicationDocumentsDirectory();
                                    final path = directory.path;

                                    var pathAsText =
                                        "$path/${_unitCard.Company}_vcf.vcf";

                                    var contactAsFile = File(pathAsText);
                                    contactAsFile.writeAsString(_unitCard
                                        .getFullVC()
                                        .getFormattedString());

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
                                  size: 170,
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
                              //============================== End of QR Code Image Box
                            ],
                          ),
                        ),
                      ),
                      //============================== End of QR Code Image Box
                    ],
                  ),
                ),
                //Start of Social Media Button Bar==============================
                Container(
                  alignment: Alignment.topCenter,

                   height: (MediaQuery.of(context).size.height - 46) * 0.085,
                   /*width: (MediaQuery.of(context).size.width - 26) * 0.33, */
                 /*  decoration: BoxDecoration(
                    //color: Colors.transparent,
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ), */

                  
                 
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        
                      ],
                    ),
                 
                  //============================== End of Social Media Button Bar
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
