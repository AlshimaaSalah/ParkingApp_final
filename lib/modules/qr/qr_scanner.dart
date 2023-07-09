import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:parking_app/modules/qr/QRscannerOverlay.dart';
import 'package:parking_app/modules/qr/result_screen.dart';
import 'package:parking_app/modules/services/spot.dart';
import 'package:parking_app/shared/components/components.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;

  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            navigateAndFinish(context, SpotScreen());
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });

                controller.switchCamera();
              },
              icon: Icon(
                Icons.camera_front,
                color: isFrontCamera ? Colors.blue : Colors.grey,
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "QRScanner",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be started automatically",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      fit: BoxFit.cover,
                      onDetect: (capture) {
                        final barcodes = capture.barcodes;

                        final Uint8List? image = capture.image;
                        for (final barcode in barcodes) {
                          if (!isScanCompleted) {
                            String code = barcode.rawValue ?? '---';
                            isScanCompleted = true;

                            //TODO:Sent userScnner To FireBase
                            //TODO: fireBase code push data 1-user id 2- code => vlaue of scann code
                            //
                            // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                            // firebaseFirestore.collection('ScannerCode').add(
                            //                                       userScannerData.toJson(),
                            // );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  closeScreen: closeScreen,
                                  code: code,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    QRScannerOverlay(
                      overlayColour: Colors.black.withOpacity(0.5),
                    ),
                  ],
                )),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                // child: const Text(
                //   "Develobed by Aya Abdelkader",
                //   style: TextStyle(
                //     color: Colors.black87,
                //     fontSize: 14,
                //     letterSpacing: 1,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
