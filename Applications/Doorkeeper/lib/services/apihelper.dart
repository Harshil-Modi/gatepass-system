import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gatepass_doorkeeper/models/doorkeeper.dart';
import 'package:gatepass_doorkeeper/models/request.dart' as req;
import 'package:http/http.dart';

class APIHandler {
// exception messages
  static String _socketExceptionMessage =
      "Can not connect to the server ($_url), or check your network connection";
  static String _otherExceptionMessage = "Something went wrong";

  static String _url = "192.168.0.106:5000";
  static Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json'
  };

  static Duration _requestDuration = Duration(seconds: 15);

  // Auth APIs
  /// Sends otp to email id
  static login({
    @required String email,
  }) async {
    String path = "/api/doorkeeper/login";
    Response res = await post(
      Uri.http(_url, path),
      headers: _headers,
      body: jsonEncode(
        {
          "email": email,
        },
      ),
    );
    return jsonDecode(res.body);
  }

  // Auth checkOTP

  ///Checks if user has entered valid OTP or not, if user has entred valid OTP then, and sets `user` object
  static checkOTP({
    @required String email,
    @required String myotp,
    @required String otp,
  }) async {
    try {
      String path = "/api/doorkeeper/checkOTP";
      Response res = await post(
        Uri.http(_url, path),
        headers: _headers,
        body: jsonEncode(
          {
            "email": email,
            "myOTP": myotp,
            "otp": otp,
          },
        ),
      ).timeout(_requestDuration);
      _setDoorkeeperObject(
          jsonDecodedResponse: jsonDecode(res.body), setToken: true);
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // Request
  /// Gets data about scanned value
  static getRequestData({String qrCodeValue}) async {
    try {
      String path = "/api/request/$qrCodeValue";
      Response res = await get(
        Uri.http(_url, path),
      ).timeout(_requestDuration);
      if (res.body.isNotEmpty) {
        _setRequestObject(
          jsonDecodedResponse: jsonDecode(res.body)["request"],
        );
      }
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // private methods
  /// Sets [`doorkeeper`] object
  static void _setDoorkeeperObject({jsonDecodedResponse, bool setToken}) {
    if (doorkeeper == null) {
      doorkeeper = Doorkeeper();
    }
    doorkeeper.id = jsonDecodedResponse["doorKeeper"]["_id"];
    doorkeeper.email = jsonDecodedResponse["doorKeeper"]["email"];
    doorkeeper.name = jsonDecodedResponse["doorKeeper"]["name"];

    if (setToken) {
      doorkeeper.token = jsonDecodedResponse["token"];
    }
  }

  /// Sets [`request`] object
  static void _setRequestObject({jsonDecodedResponse}) {
    if (req.request == null) {
      req.request = req.Request();
    }
    req.request.id = jsonDecodedResponse["_id"];
    req.request.requestStatus = jsonDecodedResponse["approved"];
    req.request.reason = jsonDecodedResponse["reason"];
    req.request.returnDateAndTime = jsonDecodedResponse["return"];
    req.request.leaveDateAndTime = jsonDecodedResponse["leave"];
  }
}
