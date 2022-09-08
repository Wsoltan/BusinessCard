import 'package:flutter/material.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

class UnitCard {
  String? FName;
  String? LName;
  String? Email;
  String? Mobile;
  String? Dep;
  String? Role;
  String? any;
  String? Ext;
  String? ppURL;
  String? Company;

  String? Adress; // P.O.Box 54668, Riyadh 11524 \n\r Kingdom of Saudi Arabia
  String? FaxNo; // +966 11 464 7687
  String? LandLineNo; // +966 11 4642 2335
  String? WebPageURL; //https://www.aisc-sa.com/
  String? fbLink; // https://www.facebook.com/atheebintergraphsaudicompany/
  String? instaLink; // https://www.instagram.com/aisc_saudi/
  String? twitterLink; // https://twitter.com/aisc_saudi
  String?
      youtubeLink; // https://www.youtube.com/channel/UCGR19tfV0PecLkIA4ty19Kw
  String? lnkdnLink; // https://www.linkedin.com/company/aisc-sa/mycompany/

  VCard _vc = VCard();

  UnitCard();

  Map<String, dynamic> toJson() => {
        'FName': FName,
        'LName': LName,
        'Email': Email,
        'Mobile': Mobile,
        'Dep': Dep,
        'Designation': Role,
        'Ext': Ext,
        'ppURL': ppURL,
        'Company': Company,
        'Adress': Adress,
        'FaxNo': FaxNo,
        'LandLineNo': LandLineNo,
        'WebPageURL': WebPageURL,
        'fbLink': fbLink,
        'instaLink': instaLink,
        'twitterLink': twitterLink,
        'youtubeLink': youtubeLink,
        'lnkdnLink': lnkdnLink,
      };

  UnitCard.fromSanpshot(snapshot, ppURL)
      : FName = snapshot.data()['FName'],
        LName = snapshot.data()['LName'],
        Email = snapshot.id,
        Mobile = snapshot.data()['Mobile'],
        Dep = snapshot.data()['Dep'],
        Role = snapshot.data()['Role'],
        Ext = snapshot.data()['Ext'],
        Company = snapshot.data()['Company'],
        ppURL = ppURL,
        Adress = snapshot.data()['Adress'],
        FaxNo = snapshot.data()['FaxNo'],
        LandLineNo = snapshot.data()['LandLineNo'],
        WebPageURL = snapshot.data()['WebPageURL'],
        fbLink = snapshot.data()['fbLink'],
        instaLink = snapshot.data()['instaLink'],
        twitterLink = snapshot.data()['twitterLink'],
        youtubeLink = snapshot.data()['youtubeLink'],
        lnkdnLink = snapshot.data()['lnkdnLink'];



     UnitCard.fromSanpshot_ar(snapshot, ppURL)
      : FName = snapshot.data()['FName_ar'],
        LName = snapshot.data()['LName_ar'],
        Email = snapshot.id,
        Mobile = snapshot.data()['Mobile'],
        Dep = snapshot.data()['Dep_ar'],
        Role = snapshot.data()['Role_ar'],
        Ext = snapshot.data()['Ext'],
        Company = snapshot.data()['Company'],
        ppURL = ppURL,
        Adress = snapshot.data()['Adress_ar'],
        FaxNo = snapshot.data()['FaxNo'],
        LandLineNo = snapshot.data()['LandLineNo'],
        WebPageURL = snapshot.data()['WebPageURL'],
        fbLink = snapshot.data()['fbLink'],
        instaLink = snapshot.data()['instaLink'],
        twitterLink = snapshot.data()['twitterLink'],
        youtubeLink = snapshot.data()['youtubeLink'],
        lnkdnLink = snapshot.data()['lnkdnLink'];

  VCard getVC() {
    _vc.firstName = this.FName!;
    _vc.firstName = this.FName!;
    _vc.lastName = this.LName!;
    _vc.workPhone = this.LandLineNo;
    _vc.cellPhone = this.Mobile!;
    _vc.workEmail = this.Email;
    _vc.role = '${this.Role!} ${this.Dep!}';
    _vc.workUrl = this.WebPageURL!;

    return _vc;
  }

  VCard getFullVC() {
    _vc.firstName = this.FName!;
    _vc.firstName = this.FName!;
    _vc.lastName = this.LName!;
    _vc.workPhone = this.LandLineNo;
    _vc.cellPhone = this.Mobile!;
    _vc.workEmail = this.Email;
    _vc.role = '${this.Role!} ${this.Dep!}';
    _vc.workUrl = this.WebPageURL!;
    _vc.logo.embedFromFile('images/${this.Company}_logo.png') ;
    _vc.organization = this.Company;
    _vc.photo.attachFromUrl(this.ppURL, 'PNG');
    _vc.workAddress.label = this.Adress!;
    _vc.workFax = this.FaxNo!;
    _vc.socialUrls!['facebook'] = this.fbLink!;
    _vc.socialUrls!['twitter'] = this.twitterLink!;
    _vc.socialUrls!['instagram'] = this.instaLink!;
    _vc.socialUrls!['youtube'] = this.youtubeLink!;
    _vc.socialUrls!['linkedIn'] = this.lnkdnLink!;




    return _vc;
  }
}

class CompanyInfo {
  String? Adress; // P.O.Box 54668, Riyadh 11524 \n\r Kingdom of Saudi Arabia
  String? FaxNo; // +966 11 464 7687
  String? LandLineNo; // +966 11 4642 2335
  String? WebPageURL; //https://www.aisc-sa.com/
  String?
      fbLink; // https://www.facebook.com/atheebintergraphsaudicompany/             https://www.facebook.com/pannesmacompany/
  String?
      instaLink; // https://www.instagram.com/aisc_saudi/                            https://www.instagram.com/pannesmacompany/
  String?
      twitterLink; // https://twitter.com/aisc_saudi                                 https://twitter.com/pannesmacompany
  String?
      youtubeLink; // https://www.youtube.com/channel/UCGR19tfV0PecLkIA4ty19Kw       https://www.youtube.com/channel/UCeP1OEfNUXnNNgjBarHI9Tw
  String?
      lnkdnLink; // https://www.linkedin.com/company/aisc-sa/mycompany/              https://www.linkedin.com/company/pannesma-co-ltd/

  CompanyInfo();

  Map<String, dynamic> toJson() => {
        'Adress': Adress,
        'FaxNo': FaxNo,
        'LandLineNo': LandLineNo,
        'WebPageURL': WebPageURL,
        'fbLink': fbLink,
        'instaLink': instaLink,
        'twitterLink': twitterLink,
        'youtubeLink': youtubeLink,
        'lnkdnLink': lnkdnLink,
      };

  CompanyInfo.fromSanpshot(snapshot)
      : Adress = snapshot.data()['Adress'],
        FaxNo = snapshot.data()['FaxNo'],
        LandLineNo = snapshot.data()['LandLineNo'],
        WebPageURL = snapshot.data()['WebPageURL'],
        fbLink = snapshot.data()['fbLink'],
        instaLink = snapshot.data()['instaLink'],
        twitterLink = snapshot.data()['twitterLink'],
        youtubeLink = snapshot.data()['youtubeLink'],
        lnkdnLink = snapshot.data()['lnkdnLink'];
}
