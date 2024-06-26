import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tembo_nida_sdk/src/views/root_app.dart';

import '../../source.dart';

class QRCodeScannerPage extends ConsumerStatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  ConsumerState<QRCodeScannerPage> createState() => _QRCodeScannerPageState();

  static const name = "scanner";
}

class _QRCodeScannerPageState extends ConsumerState<QRCodeScannerPage> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemboAppBar(label: "Scanner"),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            controller.stop();
            temboNIDASDKRootNavKey.pop(barcodes.first);
          }
        },
      ),
    );
  }
}
