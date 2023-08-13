import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:usp_ecard/core/models/user_model.dart';
import 'package:usp_ecard/ui/pages/home/widgets/appbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool disposeMenu = true;
  bool isQrCode = true;
  bool isOpsQrCode = false;

  UserModel user = UserModel(
    name: "Leonardo Pires",
    faculdade: "Faculdade de Filosofia, Ciências e Letras de Rib Preto",
    typeCurse: "GRADUACAO",
    dueDate: "12/2022",
    id: "12346775444",
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => setState(() {
          disposeMenu = true;
          isOpsQrCode = false;
        }),
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: const Color(0xFFFF9E1B),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 110),
                                  child: Column(
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
                                        width: 150,
                                        height: 220,
                                        child: Image.asset(
                                          'assets/images/profile_test.png',
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
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        user.typeCurse,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: isQrCode ? 160 : 260,
                                        height: isQrCode ? 160 : 90,
                                        color: Colors.white,
                                        child: isQrCode
                                            ? GestureDetector(
                                                onTap: () async {
                                                  setState(() => isOpsQrCode = true);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: QrImageView(
                                                    data: user.id,
                                                    version: QrVersions.auto,
                                                    size: 200.0,
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5),
                                                child: SfBarcodeGenerator(value: user.id),
                                              ),
                                      ),
                                      const SizedBox(height: 10),
                                      isQrCode
                                          ? const Text(
                                              'Código QR expira em 12/10/2023 23:59',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            )
                                          : const Column(
                                              children: [
                                                Text("Validade", style: TextStyle(color: Colors.black, fontSize: 18)),
                                                Text("01/2024", style: TextStyle(color: Color.fromARGB(255, 44, 44, 44), fontSize: 14)),
                                              ],
                                            ),
                                      SizedBox(height: isQrCode ? 20 : 40),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 160,
                                  height: 160,
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBarWidget(
                    qrCodeTap: () {
                      setState(() => isQrCode = !isQrCode);
                    },
                    closeMenu: disposeMenu,
                  ),
                ],
              ),
            ),
            isOpsQrCode
                ? Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.black.withOpacity(0.6),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 250,
                              height: 250,
                              color: Colors.white,
                              child: Center(
                                child: QrImageView(
                                  data: user.id,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
