import 'package:flutter/material.dart';
import 'package:user_application/qrcode_scanner_screen.dart';
import 'package:user_application/first_time_user.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _isFirstime = UserPreferences.isFirstTimeQRCode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code Tutorial'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<bool>(
          future: _isFirstime,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            bool isFirstTime = snapshot.data ?? true;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isFirstTime) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 100,
                            color: Color.fromARGB(255, 41, 55, 179),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "ECO Bin",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Place the QR code inside the area",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 41, 55, 179),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.qr_code_scanner,
                        size: 400,
                        color: Colors.grey[300],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const QRCodeScannerScreen(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 41, 55, 179),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("SCAN QR CODE"),
                      ),
                    ),
                  ],
                  const QRCodeScannerScreen(),
                ],
              ),
            );
          }),
    );
  }
}
