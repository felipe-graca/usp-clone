import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';

class AppBarWidget extends StatefulWidget {
  final bool closeMenu;
  final Function() qrCodeTap;
  const AppBarWidget({super.key, required this.qrCodeTap, this.closeMenu = false});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool isQrCode = false;
  bool isOpen = true;
  @override
  Widget build(BuildContext context) {
    final codeIcon = isQrCode ? Icons.qr_code_2 : CupertinoIcons.barcode;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: isOpen ? size.height * 0.1 + 160 : size.height * 0.1,
      width: size.width,
      child: Stack(
        children: [
          Container(height: size.height * 0.1, color: const Color(0xFFc66e00)),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "e-Card",
                  style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          isQrCode = true;
                        }),
                        widget.qrCodeTap(),
                      },
                      child: Icon(codeIcon, size: 26, color: Colors.black.withOpacity(0.8)),
                    ),
                    const SizedBox(width: 20),
                    Icon(Icons.more_vert, size: 26, color: Colors.black.withOpacity(0.8)),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 5,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: widget.closeMenu ? 0 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                width: widget.closeMenu ? 0 : size.width * 0.55,
                height: widget.closeMenu ? 0 : 160,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: FutureBuilder(
                    future: Future.delayed(const Duration(milliseconds: 200)),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text("Categorias", style: TextStyle(fontSize: 18)),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
                                  child: const Text(
                                    "Politica de privacidade",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text("Logout", style: TextStyle(fontSize: 18))
                              ],
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
