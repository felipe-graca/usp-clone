import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:usp_ecard/core/helpers/ui_helpers.dart';
import 'package:usp_ecard/ui/widgets/dialogs.dart';

class QrBarCodeWidget extends StatefulWidget {
  final String id;
  final bool isQrCode;
  const QrBarCodeWidget({
    super.key,
    required this.id,
    required this.isQrCode,
  });

  @override
  State<QrBarCodeWidget> createState() => _QrBarCodeWidgetState();
}

class _QrBarCodeWidgetState extends State<QrBarCodeWidget> {
  bool barCodeTap = false;
  @override
  Widget build(BuildContext context) {
    if (widget.isQrCode) {
      return GestureDetector(
        onTap: () {
          Dialogs.showCustomDialog(
            context: context,
            textInformation: 'Código QR expira em ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} 23:59',
            child: QrImageView(
              data: widget.id,
              version: QrVersions.auto,
              padding: const EdgeInsets.all(60),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: QrImageView(
                    padding: EdgeInsets.zero,
                    data: widget.id,
                    version: QrVersions.auto,
                  ),
                ),
              ),
            ),
            10.height,
            Text(
              'Código QR expira em ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} 23:59',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          barCodeTap = true;
        });
        Dialogs.showCustomDialog(
          context: context,
          textInformation: widget.id,
          isBarCode: true,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 120,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: SfBarcodeGenerator(value: widget.id),
            ),
          ),
        ).then((value) {
          setState(() {
            barCodeTap = false;
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 120,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: !barCodeTap ? SfBarcodeGenerator(value: widget.id) : null,
          ),
        ),
      ),
    );
  }
}
