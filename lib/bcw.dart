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
import 'bcls.dart';
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

class BCWUnit extends StatelessWidget {
  final UnitCard _unitCard;
  BCWUnit(this._unitCard);

  setPortraitOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
     if (MediaQuery.of(context).orientation != null) {
      setPortraitOrientation();
    }
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: ClipOval(child: (Image.network("${_unitCard.ppURL}"))),
                title: Text(
                  '${_unitCard.FName} ${_unitCard.LName}',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_unitCard.Role}",
                      style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    ),
                    Text(
                      "${_unitCard.Dep}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontStyle: FontStyle.italic),
                    ),
                    /* Text(
                          "${_unitCard.Company}",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontStyle: FontStyle.italic),
                        ), */
                  ],
                ),
                trailing: SizedBox(
                    width: 100,
                    child:
                        (Image.asset('images/${_unitCard.Company}_logo.png'))),
                //isThreeLine: true,
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('${_unitCard.Email}',
                    textDirection: TextDirection.ltr,
                    textAlign: (localLang == "ar")
                        ? TextAlign.start
                        : TextAlign.start),
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                    '${_unitCard.LandLineNo} ' + 'Ext'.tr + ' ${_unitCard.Ext}',
                    textDirection: TextDirection.ltr,
                    textAlign: (localLang == "ar")
                        ? TextAlign.start
                        : TextAlign.start),
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              ),
              ListTile(
                leading: Icon(Icons.fax),
                title: Text('${_unitCard.FaxNo}',
                    textDirection: TextDirection.ltr,
                    textAlign: (localLang == "ar")
                        ? TextAlign.start
                        : TextAlign.start),
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: Text('${_unitCard.WebPageURL}',
                    textDirection: TextDirection.ltr,
                    textAlign: (localLang == "ar")
                        ? TextAlign.start
                        : TextAlign.start),
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              ),
              SingleChildScrollView(
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
                      width: 20,
                    ),
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.maximize),
                        iconSize: 25,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => BCWLS(this._unitCard)),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              /* ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    iconSize: 25,
                    color: Colors.grey,
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
                    color: Colors.grey,
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
                    color: Colors.grey,
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
                    color: Colors.grey,
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
                    color: Colors.grey,
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
                    icon: FaIcon(FontAwesomeIcons.maximize),
                    iconSize: 25,
                    color: Colors.grey,
                    onPressed: (() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => BCWLS(this._unitCard)),
                        ),
                      );
                    }),
                  ),
                ],
              ), */
              ExpansionTile(
                title: Text(''),
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
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
                                QrEmbeddedImageStyle(size: Size(80, 40)),

                            //errorCorrectionLevel: QrErrorCorrectLevel.H ,
                          ),
                        ),
                      ),
                      //Image.asset('images/${_unitCard.Company}_logo.png'))
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
