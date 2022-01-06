import 'package:flutter/material.dart';
import 'package:gatepassStudent/model/request.dart';
import 'package:gatepassStudent/model/user.dart';
import 'package:gatepassStudent/screens/gatepass/qr.dart';
import 'package:gatepassStudent/screens/gatepass/reject.dart';
import 'package:gatepassStudent/screens/gatepass/request.dart';
import 'package:gatepassStudent/services/apihelper.dart';
import 'package:gatepassStudent/shared/const.dart';
import 'package:gatepassStudent/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loader()
        : Scaffold(
            appBar: ThemeAppBar(
              title: home_title,
            ),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Generate gatepass button
                    ThemeButtonWidth(
                      text: home_lblbtnGatepass,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        var res = await APIHandler.me();

                        setState(() {
                          _isLoading = false;
                        });

                        User newUser = User(isPending: res["isPending"]);
                        if (newUser.isPending) {
                          showSnackBar(
                              context: context,
                              content: Text(home_noNewRequest));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GenerateRequestForm();
                              },
                            ),
                          );
                        }
                      },
                    ),

                    //// Show Last request
                    ThemeButtonWidth(
                      text: home_lblbtnShowStatus,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        bool _showAck = false;
                        String _ackMsg = "";
                        await APIHandler.lastRequestStatus().then((res) {
                          if (res) {
                            if (res) {
                              if (request.requestStatus ==
                                  RequestStatus.REQUEST_STATUS_APPROVED) {
                                _showAck = false;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QrG(),
                                  ),
                                );
                              } else if (request.requestStatus ==
                                  RequestStatus.REQUEST_STATUS_REJECTED) {
                                _showAck = false;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GatepassRejected(),
                                  ),
                                );
                              } else if (request.requestStatus ==
                                  RequestStatus.REQUEST_STATUS_PENDING) {
                                _showAck = true;
                                _ackMsg = home_popupRequestStatusPending;
                              }
                            }
                          } else {
                            // user has not requested before, or all requested must have been removed
                            _showAck = true;
                            _ackMsg = home_popupRequestNoRequest;
                          }
                        }, onError: (e) {
                          _showAck = true;
                          _ackMsg = e.toString();
                        });

                        // Stops loader
                        setState(() {
                          _isLoading = false;
                        });

                        // Show acknowledgement to user
                        if (_showAck) {
                          showSnackBar(
                            context: context,
                            content: Text(_ackMsg),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
