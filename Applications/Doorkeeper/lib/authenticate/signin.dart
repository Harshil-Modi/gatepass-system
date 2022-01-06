import 'package:flutter/material.dart';
import 'package:gatepass_doorkeeper/screens/home/home.dart';
import 'package:gatepass_doorkeeper/services/apihelper.dart';
import 'package:gatepass_doorkeeper/shared/const.dart';
import 'package:gatepass_doorkeeper/shared/theme.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false, _isEmailEntered = false, _isInvalidOtp = false;
  String _email = "", _otp = "", _myOtp = "";

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loader()
        : Scaffold(
            appBar: ThemeAppBar(
              title: title,
            ),

            // Body contains the form to get data from user
            body: Center(
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            logoPath,
                            width: imageWidth,
                            height: imageHeight,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: padding,
                              right: padding,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Email Id textfield
                                  TextFormField(
                                    enabled: !_isEmailEntered,
                                    initialValue:
                                        _email.isNotEmpty ? _email : "",
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      hintText: signIn_lblTxtfieldEmailId,
                                    ),
                                    validator: (val) => (val.isEmpty
                                        ? signIn_lblTxtfieldEmailIdEmpty
                                        : validateEmail(val)
                                            ? null
                                            : signIn_lblTxtfieldEmailIdInvalid),
                                    onChanged: (val) => _email = val,
                                  ),

                                  // Otp textfield
                                  Visibility(
                                    visible: _isEmailEntered,
                                    child: TextFormField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: signIn_lblTxtfieldOtp,
                                      ),
                                      validator: (val) => (val.isEmpty
                                          ? signIn_lblTxtfieldOtpEmpty
                                          : val.length == 6
                                              // ? null
                                              ? (_otp != _myOtp ||
                                                      _isInvalidOtp)
                                                  ? signIn_lblTxtfieldOtpErrorInvalid
                                                  : null
                                              : signIn_lblTxtfieldOtpErrorLength),
                                      onChanged: (val) => _myOtp = val,
                                    ),
                                  ),

                                  //// Send OTP button
                                  Visibility(
                                    visible: !_isEmailEntered,
                                    child: ThemeButtonWidth(
                                      text: signIn_sendOtp,
                                      context: context,
                                      onPressed: () async {
                                        // check for valid email and password
                                        if (_formKey.currentState.validate()) {
                                          String acknowledgeMessage = "";

                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await APIHandler.login(
                                            email: _email,
                                          ).then(
                                            (res) {
                                              if (res.containsKey("message")) {
                                                // server returns some error
                                                acknowledgeMessage =
                                                    res["message"];
                                              } else {
                                                // user found and otp was sent to email
                                                _otp = res["otp"];
                                                acknowledgeMessage = res["msg"];

                                                setState(() {
                                                  _isEmailEntered = true;
                                                });
                                              }
                                            },
                                            onError: (e) {
                                              acknowledgeMessage = e.toString();
                                            },
                                          );

                                          // stop loader
                                          setState(() {
                                            _isLoading = false;
                                          });

                                          // acknowledgement to user
                                          showSnackBar(
                                            context: context,
                                            content: Text(
                                              acknowledgeMessage,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  //// Verify OTP button
                                  Visibility(
                                    visible: _isEmailEntered,
                                    child: ThemeButtonWidth(
                                      text: signIn_checkOtp,
                                      context: context,
                                      onPressed: () async {
                                        // check for valid email and password
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            _isLoading = true;
                                          });

                                          await APIHandler.checkOTP(
                                            email: _email,
                                            myotp: _myOtp,
                                            otp: _otp,
                                          ).then(
                                            (res) {
                                              setState(() {
                                                _isLoading = false;
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return Home();
                                                    },
                                                  ),
                                                );
                                              });
                                            },
                                            onError: (e) {
                                              showSnackBar(
                                                context: context,
                                                content: Text(e.toString()),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer of the page
            bottomNavigationBar: Container(
              child: SizedBox(
                height: singIn_footerHeight,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        singIn_doNotHaveAcc,
                        style: TextStyle(
                          fontSize: singIn_footerHeadingTextSize,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        singIn_contactAdmin.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
