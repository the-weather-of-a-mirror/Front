
import 'package:flutter/material.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Qrscanner extends StatefulWidget {
  const Qrscanner({super.key});

  @override
  State<Qrscanner> createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('거울 QR코드 스캔'),shape: Border(bottom: BorderSide(color: Colors.grey,width: 1)),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                String? res = await SimpleBarcodeScanner.scanBarcode(
                  context,
                  barcodeAppBar: const BarcodeAppBar(
                    appBarTitle: 'Test',
                    centerTitle: false,
                    enableBackButton: true,
                    backButtonIcon: Icon(Icons.arrow_back_ios),
                  ),
                  isShowFlashIcon: true,
                  delayMillis: 2000,
                  // cameraFace: CameraFace.front,
                );
                setState(() {
                  result = res as String;
                });
              },
              child: const Text('Scasn Barcode'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Scan Barcode Result: $result'),
          ],
        ),
      ),
    );
  }
}
