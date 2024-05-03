import 'package:flutter/material.dart';
import 'package:usp_ecard/core/helpers/ui_helpers.dart';
import 'package:usp_ecard/core/service/security/security_service.dart';
import 'package:usp_ecard/ui/widgets/qr_bar_code_widget.dart';
import 'package:usp_ecard/ui/widgets/usp_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = UserStore.instance.user;
  bool isQrCode = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: USPAppBarWidget(
        hasLoggedIn: true,
        isQrCode: isQrCode,
        qrCodeTap: () {
          setState(() {
            isQrCode = !isQrCode;
          });
        },
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xFFFF9E1B),
        child: SingleChildScrollView(
          child: Column(
            children: [
              4.height,
              SizedBox(
                width: 180,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  const Text(
                    "Universidade de São Paulo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "ALUNO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 160,
                    height: 220,
                    child: Image.file(
                      UIHelpers.base64ToFile(user.base64Image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user.id,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      user.faculdade,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  8.height,
                  Text(
                    user.typeCurse,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  QrBarCodeWidget(
                    id: user.id,
                    isQrCode: isQrCode,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
