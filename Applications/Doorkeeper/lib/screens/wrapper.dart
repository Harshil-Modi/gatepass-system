import 'package:flutter/material.dart';
import 'package:gatepass_doorkeeper/authenticate/authenticate.dart';
import 'package:gatepass_doorkeeper/models/doorkeeper.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // doorkeeper model checking if not null then Home() else
    return doorkeeper!= null ? Home():Authenticate();

  }
}
