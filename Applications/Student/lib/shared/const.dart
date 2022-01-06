import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Duration snackBarDuration = Duration(seconds: 3);
const int txtfieldMultilinesMaxLines = 3;
const int txtfieldMultilinesMaxLength = 70;
const int request_dtpickerNextAllowedDays = 10;
const int passwordMinLength = 6;
const int passwordMaxLength = 32;
const double buttonWidth = 200;
const double padding = 10;
const double sizedBoxheight = 20;

const double singIn_footerHeight = 50;
const double singIn_footerHeadingTextSize = 16;
const double imageHeight = 100;
const double imageWidth = 100;
const double infoTextSize = 20;
const double qr_codeImgSize = 200;
// ignore: non_constant_identifier_names
final double qr_codeContainerSize = qr_codeImgSize + (qr_codeImgSize / 2);
const String title = "Student";
// const String singIn = "Login";
const String signIn_sendOtp = "Send OTP";
const String signIn_checkOtp = "Verify OTP";
const String dummyUsername = "Student";
final String passwordLengthErrorText =
    "Password length must be between $passwordMinLength and $passwordMaxLength";
const String logoPath = "assets/logo.png";
const String home_title = "Home";
const String home_lblbtnGatepass = "Gatepass";
const String home_lblbtnShowStatus = "Last request";

const String home_noNewRequest =
    'Your last request is still pending, you cannot generate new request!';
const String home_popupRequestStatusPending =
    "Your request is still under review";
const String home_popupRequestNoRequest = "We could not find your last request";

const String singIn_doNotHaveAcc = "Don't have an account?";
const String singIn_contactAdmin = "Contact admin";
const String signIn_lblTxtfieldEmailId = "Enter email id";
const String signIn_lblTxtfieldEmailIdEmpty = "Email id can't be empty";
const String signIn_lblTxtfieldEmailIdInvalid = "Invalid email id";
const String signIn_lblTxtfieldOtp = "Enter OTP";
const String signIn_lblTxtfieldOtpEmpty = "OTP can't be empty";
const String signIn_lblTxtfieldOtpErrorLength = "OTP's length is 6 characters";
const String signIn_lblTxtfieldOtpErrorInvalid = "Invalid OTP";
const String signIn_lblTxtfieldErrorText = "Invalid email id";

const String request_title = "Leave application form";
const String request_lblTxtfieldReason = "Reason";
const String request_lblTxtfieldReasonEmpty = "Please enter reason";
const String request_lblDtpickerOutDate = "Leaving date";
const String request_lblDtpickerOutTime = "Leaving time";
const String request_lblDtpickerInDate = "Returning date";
const String request_lblDtpickerInTime = "Returning time";
const String request_lblDtpickerOutDateTimeEmpty =
    "Leaving date and/or time can't be empty";
const String request_lblDtpickerInDateTimeEmpty =
    "Returning date and/or time can't be empty";
const String request_lblDtpickerInDateTimeLesser =
    "Returning date and time should be greater than Leave date and time";

const String request_lblBtnApply = "Ask for leave";
const String requset_infoRequestAdded =
    "Your request was added, and is under review";
const String requset_infoRequestAddingError =
    "Can not process your request at this moment";

const String requset_infoRequestAlreadyAdded =
    "You cannot make another request";

const String qr_scanInfo = "Scan this QR Code with doorkeeper's device";

const String reject_sadGhostImgpath = "assets/sad-ghost.png";
const String reject_txtPermissionRejected =
    "Sorry\nYou didn't get permission from the rector";

Widget loader() {
  return Container(
    color: Colors.white,
    child: SpinKitRing(
      color: Colors.blue,
    ),
  );
}

var themeButtonTextStyle = GoogleFonts.openSans(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

var shapeRounded = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(30.0),
);

bool isBetween(int number, int min, int max) =>
    ((min <= number) && (number <= max));

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}
