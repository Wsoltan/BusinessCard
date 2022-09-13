
import 'package:get/get_navigation/get_navigation.dart';

class MyLocale implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "ar": {
      "Cards List": "قائمة الكروت",
      "Log In": "دخول",
      "Password" : "كلمة المرور",
      'Email address': "البريد الأليكتروني",
      'Ext': "-",
      'Show Picture':'اظهر الصورة'
    }, 
    "en": {
      "Cards List": "Cards List",
      "Log In": "Log In",
      "Password": "Password",
      'Email address': "Email address",
      'Ext': "Ext.",
      'Show Picture':'Show Picture'
      }
    };
}
