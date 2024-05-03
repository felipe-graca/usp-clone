import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usp_ecard/core/helpers/ui_helpers.dart';

class Dialogs {
  Dialogs._();

  static Future<T?> _baseDialog<T>({
    required BuildContext context,
    required Widget child,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 20),
    bool hasRedBorder = false,
    String textInformation = '',
    bool isBarCode = false,
  }) async {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withOpacity(.6),
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                margin: margin,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!isBarCode) ...[
                        Text(
                          textInformation,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        18.height,
                      ],
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            child,
                            if (isBarCode) ...[
                              Text(
                                textInformation,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ],
                        ),
                      ),
                      if (isBarCode) 120.height,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required Widget child,
    required String textInformation,
    bool hasRedBorder = false,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 16),
    bool isBarCode = false,
  }) async {
    return _baseDialog<T>(
      context: context,
      child: child,
      margin: margin,
      textInformation: textInformation,
      isBarCode: isBarCode,
    );
  }
}
