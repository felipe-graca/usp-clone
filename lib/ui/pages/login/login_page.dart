import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:usp_ecard/core/helpers/ui_helpers.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';
import 'package:usp_ecard/core/service/security/i_security_service.dart';
import 'package:usp_ecard/ui/widgets/login_form_widget.dart';
import 'package:usp_ecard/ui/widgets/usp_app_bar_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _securityService = GetIt.I<ISecurityService>();

  bool _isLoading = false;

  Future<void> authenticate(String password) async {
    setState(() {
      _isLoading = true;
    });
    final result = await _securityService.authenticate(password: password);

    if (result || (await _securityService.isAuthenticated())) {
      final hasUserData = await _securityService.getUser();

      if (hasUserData) {
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
        return;
      }

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.profile, (route) => false);
      return;
    }
    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Senha de ativação inválida'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: USPAppBarWidget(qrCodeTap: () {}),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    color: const Color.fromARGB(255, 241, 241, 241).withOpacity(.4),
                  ),
                  30.height,
                  LoginFormWidget(authenticate: authenticate),
                  40.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Para entrar no sistema, use seu número USP e a senha cadastrada no sistema https://uspdigital.usp.br',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(.8),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
