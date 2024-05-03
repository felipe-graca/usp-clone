import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';

class USPAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool hasLoggedIn;
  final bool isQrCode;
  final Function() qrCodeTap;
  const USPAppBarWidget({super.key, this.hasLoggedIn = false, this.isQrCode = false, required this.qrCodeTap});

  @override
  State<USPAppBarWidget> createState() => _USPAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _USPAppBarWidgetState extends State<USPAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: !widget.hasLoggedIn ? 4 : 0,
      color: Color(!widget.hasLoggedIn ? 0xff00828F : 0xFFC66E00),
      child: SafeArea(
        top: !widget.hasLoggedIn,
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(!widget.hasLoggedIn ? 0xff00828F : 0xFFC66E00),
          title: Row(
            mainAxisAlignment: !widget.hasLoggedIn ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'e-Card',
                style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 25),
              ),
              if (widget.hasLoggedIn) ...[
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.qrCodeTap();
                      },
                      child: AbsorbPointer(
                        child: Row(
                          children: [
                            if (widget.isQrCode) ...[
                              IconButton(
                                icon: const Icon(Icons.qr_code_2),
                                onPressed: () {},
                              ),
                            ] else ...[
                              IconButton(
                                icon: Icon(CupertinoIcons.barcode, size: 26, color: Colors.black.withOpacity(0.8)),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(AppRoutes.profile);
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    PopupMenuButton<int>(
                      padding: EdgeInsets.zero,
                      onSelected: (item) {
                        if (item == 1) {
                          Navigator.of(context).pushNamed(AppRoutes.profile);
                          return;
                        }
                        if (item == 2) {
                          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                          return;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            'Categorias',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ),
                        PopupMenuItem<int>(
                            value: 1,
                            child: Text(
                              'Política de privacidade',
                              style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 18),
                            )),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text(
                            'Logout',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
