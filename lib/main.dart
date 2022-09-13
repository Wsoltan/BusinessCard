import 'dart:ffi';

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
bool ppisvisible = false;

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

// I have deleted LS_BC widget from main.dart to clean up code, presume Git will keep the older version

