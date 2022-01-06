import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gatepassStudent/model/user.dart';
import 'package:gatepassStudent/screens/wrapper.dart';
import 'package:gatepassStudent/services/apihelper.dart';
import 'package:gatepassStudent/shared/const.dart';
import 'package:gatepassStudent/shared/theme.dart';

class GenerateRequestForm extends StatefulWidget {
  @override
  _GenerateRequestFormState createState() => _GenerateRequestFormState();
}

class _GenerateRequestFormState extends State<GenerateRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final DateTime now = DateTime.now();

  /// now.hours + 2, init for return date
  DateTime _nowPlus2Hours;

  // form field
  String _reason;
  DateTime _leaveDate;
  DateTime _returnDate;

  bool _isDataAdded = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    _nowPlus2Hours = now.add(new Duration(hours: 2));
    return _isLoading
        ? loader()
        : Scaffold(
            appBar: ThemeAppBar(
              title: request_title,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Wrap(
                      children: [
                        Column(
                          children: [
                            // Reason field
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: txtfieldMultilinesMaxLines,
                              maxLength: txtfieldMultilinesMaxLength,
                              autofocus: false,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return request_lblTxtfieldReasonEmpty;
                                }
                                _reason = value.trim();
                                return null;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                hintText: request_lblTxtfieldReason,
                                labelText: request_lblTxtfieldReason,
                              ),
                            ),

                            // Leave date and time field
                            DateTimePicker(
                              initialValue: DateTime(now.year, now.month,
                                      now.day, now.hour, now.minute, now.second)
                                  .toString(),
                              type: DateTimePickerType.dateTimeSeparate,
                              firstDate: DateTime(now.year, now.month, now.day,
                                  now.hour, now.minute, now.second),
                              lastDate: DateTime(
                                  now.year,
                                  now.month,
                                  (now.day + request_dtpickerNextAllowedDays),
                                  now.hour,
                                  now.minute,
                                  now.second),
                              dateLabelText: request_lblDtpickerOutDate,
                              timeLabelText: request_lblDtpickerOutTime,
                              onChanged: (String value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    _leaveDate = DateTime.parse(value);
                                  });
                                }
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return request_lblDtpickerOutDateTimeEmpty;
                                }
                                _leaveDate = DateTime.parse(value);

                                return null;
                              },
                            ),

                            // Return date and time field
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              initialValue: _nowPlus2Hours.toString(),
                              firstDate: _nowPlus2Hours,
                              lastDate: DateTime(
                                  now.year,
                                  now.month,
                                  (now.day + request_dtpickerNextAllowedDays),
                                  now.hour,
                                  now.minute,
                                  now.second),
                              dateLabelText: request_lblDtpickerInDate,
                              timeLabelText: request_lblDtpickerInTime,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return request_lblDtpickerInDateTimeEmpty;
                                }
                                _returnDate = DateTime.parse(value);
                                return null;
                              },
                            ),

                            SizedBox(height: sizedBoxheight),

                            // Submit button
                            ThemeButtonWidth(
                              text: request_lblBtnApply,
                              onPressed: () async {
                                if (!_isDataAdded) {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    // API calling
                                    _isDataAdded = await APIHandler.makeRequest(
                                      reason: _reason,
                                      leaveDateAndTime: _leaveDate.toString(),
                                      returnDateAndTime: _returnDate.toString(),
                                      name: user.name,
                                    );

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showSnackBar(
                                      context: context,
                                      content: Text(
                                        _isDataAdded
                                            ? requset_infoRequestAdded
                                            : requset_infoRequestAddingError,
                                      ),
                                      action: SnackBarAction(
                                        label: 'Okay',
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Wrapper(),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context: context,
                                    content: Text(
                                      requset_infoRequestAlreadyAdded,
                                    ),
                                  );
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Wrapper(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
