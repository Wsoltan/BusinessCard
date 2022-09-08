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




String loggedInEmail = '';
String _AppPath = '';
var doc;
 String localLang = "en";

final List<VCard> _LvCard = [];
var vCard = VCard();
List<Object> _Docs = [];


Future main() async {
  // Step 3

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  

  runApp(MyApp());
}

final pnavigatorKey = GlobalKey<NavigatorState>();



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Locale _locale  = Locale.fromSubtags(languageCode: 'en') ;
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: pnavigatorKey,
      title: 'Atheeb Business Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
          backgroundColor: Colors.blue,
          accentColor: Colors.deepPurpleAccent,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.blueAccent,
            textTheme: ButtonTextTheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          )),
          locale: Get.deviceLocale,
          translations: MyLocale(),
          
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
               
                return ViewCardsList();
              } else {
                return loginWidget();
              }
            }));
  }
}

class loginWidget extends StatefulWidget {
  loginWidget({Key? key}) : super(key: key);

  @override
  State<loginWidget> createState() => _loginWidgetState();
}

class _loginWidgetState extends State<loginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        loggedInEmail = emailController.text.trim();
        
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString().substring(
                  e.toString().lastIndexOf(']') + 1,
                  (e.toString().length),
                ),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
      //pnavigatorKey.currentState!.popUntil((route) => route.isFirst);

      Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ViewCardsList()),
                  ),
                );
    }

    return Material(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address'.tr,
              ),
            ),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'.tr),
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: signIn, child:  Text('Log In'.tr)),
          ],
        ),
      ),
    );
  }
}



class LS_FBC extends StatefulWidget {
  const LS_FBC({Key? key}) : super(key: key);

  @override
  State<LS_FBC> createState() => _LS_FBCState();
}

class _LS_FBCState extends State<LS_FBC> {
  setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation != null) {
      setLandscapeOrientation();
    }
    return Container(
      //height: 100,
      //color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      padding: const EdgeInsets.all(10.0),
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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // = snapshot.data.docs[0];
                for (var i = 0; i < snapshot.data.docs.length; i++) {
                  doc = snapshot.data.docs[i];
                  if (doc.id == loggedInEmail) {
                    break;
                  }
                }

                return Column(
                  children: [
                    //Row 1 =================================================================
                    Row(
                      children: [
                        //================ Start of Personal Picture Box
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.transparent, width: 2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              //topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              //bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 46) * 0.35,
                          width:
                              (MediaQuery.of(context).size.width - 26) * 0.22,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              ),
                              child: Image.asset('images/PPSample1M.png'),
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
                          width:
                              (MediaQuery.of(context).size.width - 26) * 0.50,
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
                                    '${doc['FName']}',
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
                                    '${doc['Designation']}',
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
                                    '${doc['Dep']}',
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
                          height:
                              (MediaQuery.of(context).size.height - 46) * 0.35,
                          width:
                              (MediaQuery.of(context).size.width - 26) * 0.25,
                          child: Image.asset('images/Pannesma_logo.png'),
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
                          height:
                              (MediaQuery.of(context).size.height - 46) * 0.55,
                          width:
                              (MediaQuery.of(context).size.width - 26) * 0.60,
                          child: ListView(
                            children: [
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                leading: FaIcon(FontAwesomeIcons.envelope),
                                title: Text('${doc.id}'),
                              ),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                leading: FaIcon(FontAwesomeIcons.phone),
                                title: Text(
                                    "+966 11 462 2335    Ext.:${doc['Ext']},"),
                              ),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                leading: FaIcon(FontAwesomeIcons.mobile),
                                title: Text("${doc['Mobile']},"),
                              ),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                leading: FaIcon(FontAwesomeIcons.weebly),
                                title: Text("www.aisc-sa.com "),
                              ),
                            ],
                          ),
                        ),
                        //============================== Start of QR Code Image Box
                        Container(
                          height:
                              (MediaQuery.of(context).size.height - 46) * 0.45,
                          width:
                              (MediaQuery.of(context).size.width - 26) * 0.40,
                          child: Align(
                            alignment: Alignment.center,
                            child: QrImage(
                              data:
                                  "BEGIN:VCARD\r\nVERSION:2.1\r\nN:Wael;Hala;;;\r\nFN:Hala Wael\r\nTEL;CELL:00201011070487\r\nTEL;X-CUSTOM(CHARSET=UTF-8,ENCODING=QUOTED-PRINTABLE,=53=61=62=69=73=20=49=64):9458\r\nEMAIL;HOME:hala.w.soultan@gmail.com\r\nEND:VCARD",
                              version: QrVersions.auto,
                              embeddedImage: AssetImage('images/Atheeb.png'),
                              //embeddedImageStyle:  QrEmbeddedImageStyle(size: Size(40, 20)),

                              //errorCorrectionLevel: QrErrorCorrectLevel.H ,
                            ),
                          ), //Image.asset('images/QRSample1.png'),
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
                          height:
                              (MediaQuery.of(context).size.height - 46) * 0.10,
                          width:
                              (MediaQuery.of(context).size.width - 26) * 0.67,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.facebook),
                                iconSize: 25,
                                color: Colors.blue,
                                tooltip: 'Increase volume by 5',
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.youtube),
                                iconSize: 25,
                                color: Colors.blue,
                                tooltip: 'Increase volume by 5',
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.instagram),
                                iconSize: 25,
                                color: Colors.blue,
                                tooltip: 'Increase volume by 5',
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.twitter),
                                iconSize: 25,
                                color: Colors.blue,
                                tooltip: 'Increase volume by 5',
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.linkedin),
                                iconSize: 25,
                                color: Colors.blue,
                                tooltip: 'Increase volume by 5',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    //bottomRight: Radius.circular(30),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      26) *
                                                  0.09,
                                              (MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      46) *
                                                  0.10)),
                                      child: IconButton(
                                        icon: const FaIcon(
                                            FontAwesomeIcons.solidMessage),
                                        iconSize: 25,
                                        color: Colors.blue,
                                        tooltip: 'Increase volume by 5',
                                        onPressed: createVCard,
                                      )), /* Text(
                                      'Share ME',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), */
                                ),

                                /* ElevatedButton(
                                      onPressed: testFireBase,
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            (MediaQuery.of(context).size.width -
                                                    26) * 0.09,
                                            (MediaQuery.of(context).size.height -
                                                    46) * 0.10)),
                                      child: IconButton(
                                        icon: const FaIcon(FontAwesomeIcons
                                            .solidMessage),
                                        iconSize: 25,
                                        color: Colors.blue,
                                        tooltip: 'Increase volume by 5',
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                        },
                                      )), */
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    //bottomRight: Radius.circular(30),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: testFireBase,
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      26) *
                                                  0.05,
                                              (MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      46) *
                                                  0.10)),
                                      child: IconButton(
                                        icon: const FaIcon(
                                            FontAwesomeIcons.envelope),
                                        iconSize: 25,
                                        color: Colors.blue,
                                        tooltip: 'Increase volume by 5',
                                        onPressed: sendEmail,
                                      )),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    //topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: testFireBase,
                                      child: IconButton(
                                        icon: const FaIcon(FontAwesomeIcons
                                            .arrowRightFromBracket),
                                        iconSize: 25,
                                        color: Colors.blue,
                                        tooltip: 'Increase volume by 5',
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  void testFireBase() async {}

  void createVCard() async {
    
  }

  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$fileName.txt'; // 3

    return filePath;
  }
}

void sendEmail() async {
  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['wael.soltan@gmail.com'],
    /* cc: ['cc@example.com'],
  bcc: ['bcc@example.com'], 
  attachmentPaths: ['images/PPSample1M.png'],*/
    isHTML: false,
  );
  try {
    await FlutterEmailSender.send(email);
    print('sent');
  } catch (e) {
    print('not sent:' + e.toString());
  }
}
