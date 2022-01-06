import 'package:flutter/material.dart';
import 'package:gatepassStudent/shared/const.dart';

class GatepassRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Wrap(
            children: [
              Column(
                children: [
                  Image.asset(
                    reject_sadGhostImgpath,
                    width: imageWidth,
                    height: imageHeight,
                  ),
                  SizedBox(height: sizedBoxheight),
                  Text(
                    reject_txtPermissionRejected,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: infoTextSize,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
