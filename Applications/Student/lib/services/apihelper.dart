import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gatepassStudent/model/request.dart' as req;
import 'package:gatepassStudent/model/user.dart';
import 'package:http/http.dart';

class APIHandler {
  // exception messages
  static String _socketExceptionMessage =
      "Can not connect to the server ($_url), or check your network connection";
  static String _otherExceptionMessage = "Something went wrong";

  // other static variables
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
    try {
      String path = "/api/auth/login";
      Response res = await post(
        Uri.http(_url, path),
        headers: _headers,
        body: jsonEncode(
          {
            "email": email,
          },
        ),
      ).timeout(_requestDuration);
      return jsonDecode(res.body);
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // Auth checkOTP

  ///Checks if user has entered valid OTP or not, if user has entred valid OTP then, and sets `user` object
  static checkOTP({
    @required String email,
    @required String myotp,
    @required String otp,
  }) async {
    try {
      String path = "/api/auth/checkOTP";
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
      _setUserObject(jsonDecodedResponse: jsonDecode(res.body), setToken: true);
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // auth getCurrentUser
  /// Gets data to check whether user can make a new request or not
  static me() async {
    try {
      String path = "/api/auth/me";
      Response res = await post(
        Uri.http(_url, path),
        headers: {
          'x-authorization-token': 'berear ${user.token}',
        },
      ).timeout(_requestDuration);

      if (res.body.isNotEmpty) {
        return jsonDecode(res.body);
      }
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // Request APIs
  // Request myrequests
  /// Sets `request` object if previous request was found and returns true, else returns false
  static lastRequestStatus() async {
    try {
      String path = "api/request/getRequest";
      Response res = await post(
        Uri.http(_url, path),
        headers: {
          'x-authorization-token': "berear ${user.token}",
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      );
      var reqs = jsonDecode(res.body)["requests"];
      if (reqs.length > 0) {
        _setRequestObject(jsonDecodedResponse: reqs[reqs.length - 1]);
        return true;
      }
      return false;
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // Request makeRequest
  /// Returns true if data is added successfully, and sets objects `user` and `request`
  static makeRequest({
    @required String reason,
    @required String returnDateAndTime,
    @required String leaveDateAndTime,
    @required String name,
  }) async {
    try {
      String path = "api/request/";
      Response res = await post(
        Uri.http(_url, path),
        headers: {
          'x-authorization-token': "berear ${user.token}",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "reason": reason,
            "return": returnDateAndTime,
            "leave": leaveDateAndTime,
            "name": name,
          },
        ),
      ).timeout(_requestDuration);
      var jsonDecodedBody = jsonDecode(res.body);
      if (jsonDecodedBody["request"] != null &&
          jsonDecodedBody["user"] != null) {
        _setRequestObject(jsonDecodedResponse: jsonDecodedBody["request"]);
        _setUserObject(jsonDecodedResponse: jsonDecodedBody);
        return true;
      }
      return false;
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // private methods
  static void _setUserObject(
      {@required jsonDecodedResponse, setToken = false}) {
    if (user == null) {
      user = User();
    }
    user.id = jsonDecodedResponse["user"]["_id"];
    user.email = jsonDecodedResponse["user"]["email"];
    user.mobile = jsonDecodedResponse["user"]["mboile"];
    user.name = jsonDecodedResponse["user"]["name"];
    user.profilePic = jsonDecodedResponse["user"]["profilePic"];
    user.isPending = jsonDecodedResponse["user"]["isPending"];

    if (setToken) {
      user.token = jsonDecodedResponse["token"];
    }
  }

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
