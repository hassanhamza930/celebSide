import 'package:celebside/services/fetchUsersData.dart';
import "package:firebase_dynamic_links/firebase_dynamic_links.dart";
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";



Future<String> buildCelebIdDynamicLink({@required String celebId}) async {

String url = "https://letsvibe.page.link";
Map celebInfo= await getCelebrityData(id: celebId);


final DynamicLinkParameters parameters = DynamicLinkParameters(
  uriPrefix: url,
  link: Uri.parse('${url}/post/${celebId}'),
  androidParameters: AndroidParameters(
    packageName: "com.brackets.celebside",
    minimumVersion: 0,
  ),
  iosParameters: IosParameters(
    bundleId: "com.brackets.celebside",
    minimumVersion: '0',
  ),
  socialMetaTagParameters: SocialMetaTagParameters(
      description: "Click to view profile.",
      imageUrl:
      Uri.parse("${celebInfo["imgSrc"]}"),
      title: "${celebInfo['fullName']}"),
);

final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
return dynamicUrl.shortUrl.toString();

}