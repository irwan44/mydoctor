import 'dart:developer';
import 'dart:io';

import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/widgets/myassetsimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          buildQrView(),
          Positioned(
            bottom: 43,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: MySvgAssetsImg(
                imageName: "cross_white.svg",
                fit: BoxFit.cover,
                imgHeight: 60,
                imgWidth: 60,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 30,
            child: InkWell(
              onTap: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              child: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  log('${snapshot.data}');
                  return MyAssetsImg(
                    imageName: "camera_flip.png",
                    fit: BoxFit.cover,
                    imgHeight: 40,
                    imgWidth: 40,
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: InkWell(
              onTap: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              child: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  log('${snapshot.data}');
                  return MyAssetsImg(
                    imageName: snapshot.data == true
                        ? "flash_off.png"
                        : "flash_on.png",
                    fit: BoxFit.cover,
                    imgHeight: 40,
                    imgWidth: 40,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQrView() {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 285.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: white,
          borderRadius: 0,
          borderLength: 70,
          borderWidth: 15,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        log(result.toString());
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
