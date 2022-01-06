import 'package:flutter/material.dart';
import 'package:gatepassStudent/model/request.dart';
import 'package:gatepassStudent/shared/const.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: qr_codeContainerSize,
          child: Wrap(
            children: [
              Column(
                children: [
                  ClipPath(
                    /// Doc id as data
                    child: QrImage(
                      size: qr_codeImgSize,
                      data: request.id,
                    ),
                  ),
                  SizedBox(height: sizedBoxheight),
                  Text(
                    qr_scanInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: infoTextSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
