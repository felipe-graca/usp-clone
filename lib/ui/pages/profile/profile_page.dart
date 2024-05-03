// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usp_ecard/core/helpers/ui_helpers.dart';
import 'package:usp_ecard/core/models/user_model.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';
import 'package:usp_ecard/core/service/security/i_security_service.dart';
import 'package:usp_ecard/ui/widgets/usp_app_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String base64Image = '';
  final _nameController = TextEditingController();

  final securityService = GetIt.I<ISecurityService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9E1B),
      appBar: USPAppBarWidget(hasLoggedIn: true, qrCodeTap: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                ),
              ),
              50.height,
              const Text('Foto de perfil', style: TextStyle(color: Colors.white)),
              20.height,
              Center(
                child: GestureDetector(
                  onTap: () {
                    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
                      if (value != null) {
                        setState(() {
                          base64Image = UIHelpers.imagePathToBase64(value.path);
                        });
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: Container(
                      width: 150,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        image: base64Image.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(UIHelpers.base64ToFile(base64Image)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: base64Image.isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 50,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              50.height,
              ElevatedButton(
                onPressed: () async {
                  if (_nameController.text.isNotEmpty && base64Image.isNotEmpty) {
                    String id = '';
                    for (int i = 0; i < 8; i++) {
                      id += math.Random().nextInt(10).toString();
                    }

                    final user = UserModel(
                      name: _nameController.text,
                      base64Image: base64Image,
                      faculdade: 'Faculdade de Filosofia, Ciências e Letras de Rib Preto',
                      typeCurse: 'GRADUAÇÃO',
                      id: id,
                    );
                    final hasSavedUser = await securityService.saveUser(user: user);

                    if (!hasSavedUser) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erro ao salvar usuário'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    if (!mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os campos'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                child: const Center(child: Text('Salvar')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
