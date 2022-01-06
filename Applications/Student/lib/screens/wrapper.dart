import 'package:flutter/material.dart';
import 'package:gatepassStudent/authenticate/authenticate.dart';
import 'package:gatepassStudent/model/user.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return user == null ? Authenticate() : Home();
  }
}
