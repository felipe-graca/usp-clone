import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class USPAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const USPAppBarWidget({super.key});

  @override
  State<USPAppBarWidget> createState() => _USPAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _USPAppBarWidgetState extends State<USPAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: const Color(0xff00828F),
      child: SafeArea(
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff0098A6),
          title: Row(
            children: [
              Text(
                'e-Card',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
