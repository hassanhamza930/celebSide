import 'package:celebside/pages/celebrity/home/editProfile.dart';

class userDetails {
  final String username;
  final String email;
  final String fullName;
  final String phone;
  final String phoneCode;
  final DateTime dob;
  final String password;
  final String country;
  final bool notificationPermission;
  final String accountType;
  final String imgSrc;
  final double wallet;
  userDetails({
    this.username,
    this.email,
    this.fullName,
    this.phone,
    this.phoneCode,
    this.dob,
    this.password,
    this.country,
    this.notificationPermission,
    this.accountType,
    this.imgSrc,
    this.wallet
  }
  );

  userDetails.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        fullName = json['fullName'],
        phone = json['phone'],
        phoneCode=json["countryCode"],
        dob = DateTime.parse(json['dob'].toDate().toString()),
        password = json['password'],
        country =json["country"],
        notificationPermission=json["notificationPermission"],
        accountType=json["accountType"],
        imgSrc=json["imgSrc"],
        wallet=json["wallet"]
  ;

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'fullName': fullName,
        'phone': phone,
        'dob': dob,
        "countryCode":phoneCode,
        'password': password,
        "country":country,
        "notificationPermission":notificationPermission,
        "accountType":accountType,
        "imgSrc":imgSrc,
        "wallet": wallet
      };
}
