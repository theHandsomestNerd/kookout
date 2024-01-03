import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../config/default_config.dart';

class BugReportClient {
  String token = "";

  BugReportClient() {
    FirebaseAuth.instance.currentUser?.getIdToken().then((theToken) {
      token = theToken ?? "";
    });
  }

  Future<String?> getIdToken() async {
    if (token != "") {
      if (kDebugMode) {
        print("Using cached Id Token");
      }
      return token;
    } else {
      if (kDebugMode) {
        print("Retrieving Id Token");
      }
      String? theToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (theToken != null) {
        token = theToken;
        return theToken;
      }
      return null;
    }
  }

  Future<void> submitBugReport(String title, String description,
      String filename, fileBytes, BuildContext context) async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (DefaultConfig.theAuthBaseUrl != null) {
      var request = http.MultipartRequest('POST',
          Uri.parse("${DefaultConfig.theAuthBaseUrl}/submit-bug-report"));

      request.headers.addAll({"authorization": "Bearer $token"});

      if (filename != "") {
        request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
            contentType: MediaType('application', 'octet-stream'),
            filename: filename));
      }

      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['uiVersion'] = DefaultConfig.theVersion+"."+DefaultConfig.thebuildNumber;
      request.fields['apiVersion'] = DefaultConfig.theApiVersion;
      request.fields['uiSanityDB'] = DefaultConfig.theSanityDB;
      request.fields['apiSanityDB'] = DefaultConfig.theApiDb;
      if (kDebugMode) {
        print("Before bug submission ui Version ${DefaultConfig.theVersion}");
      }
      if (kDebugMode) {
        print("Before bug submission api version${DefaultConfig.theApiVersion}");
      }
      if (kDebugMode) {
        print("Before bug submission ui db${DefaultConfig.theSanityDB}");
      }
      if (kDebugMode) {
        print("Before bug submission api db ${DefaultConfig.theApiDb}");
      }

      await request.send();
      return;
    }
  }
}
