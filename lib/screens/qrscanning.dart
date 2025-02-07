import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedCode = '';
  bool isFlashOn = false;
  bool isCameraFront = false;

  // To ensure hot reload works properly with the QR scanner
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Flash toggle button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        icon: Icon(
                          isFlashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.black,
                        ),
                        label: Text(
                          isFlashOn ? 'Flash Off' : 'Flash On',
                          style: const TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {
                            isFlashOn = !isFlashOn;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      // Camera flip button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        icon: Icon(
                          isCameraFront
                              ? Icons.camera_rear
                              : Icons.camera_front,
                          color: Colors.black,
                        ),
                        label: Text(
                          isCameraFront ? 'Rear Camera' : 'Front Camera',
                          style: const TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          await controller?.flipCamera();
                          setState(() {
                            isCameraFront = !isCameraFront;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Scanned Results',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      scannedCode.isEmpty
                          ? 'No QR code scanned yet'
                          : 'Scanned Code: $scannedCode',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: scannedCode.isEmpty
                        ? null
                        : () {
                            // Handle the scanned code
                            // For example, validate attendance, check inventory, etc.
                            _processScannedCode(scannedCode);
                          },
                    child: const Text(
                      'Process Scanned Code',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedCode = scanData.code ?? '';
      });
    });
  }

  void _processScannedCode(String code) {
    // TODO: Implement your business logic here
    // For example:
    // - Validate student/employee attendance
    // - Check inventory items
    // - Verify tickets/passes
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Processing QR Code'),
        content: Text('Processing code: $code'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                scannedCode = '';
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}