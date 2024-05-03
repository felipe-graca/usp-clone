import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usp_ecard/core/helpers/ui_helpers.dart';

class LoginFormWidget extends StatefulWidget {
  final Future<void> Function(String) authenticate;
  const LoginFormWidget({super.key, required this.authenticate});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool hasUsernameFocus = false;
  bool hasPasswordFocus = false;

  final _usernameGlobalKey = GlobalKey<FormState>();
  final _passwordGlobalKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController(text: '87456325');
  final _passwordController = TextEditingController();

  @override
  void initState() {
    usernameFocusNode.addListener(() {
      setState(() {
        hasUsernameFocus = usernameFocusNode.hasFocus;
      });
    });

    passwordFocusNode.addListener(() {
      setState(() {
        hasPasswordFocus = passwordFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();

    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width * .7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color.fromARGB(255, 202, 202, 202),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          28.height,
          Text(
            'Usuário',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          8.height,
          Container(
            height: 40,
            decoration: hasUsernameFocus
                ? BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color.fromARGB(129, 0, 137, 201),
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  )
                : null,
            child: TextFormField(
              key: _usernameGlobalKey,
              focusNode: usernameFocusNode,
              controller: _usernameController,
              cursorWidth: 1,
              cursorHeight: 24,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 201, 201, 201),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          16.height,
          Text(
            'Senha',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          8.height,
          AnimatedContainer(
            height: 40,
            duration: const Duration(seconds: 5),
            decoration: hasPasswordFocus
                ? BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color.fromARGB(129, 0, 137, 201),
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  )
                : null,
            child: TextFormField(
              key: _passwordGlobalKey,
              focusNode: passwordFocusNode,
              controller: _passwordController,
              obscureText: true,
              cursorWidth: 1,
              cursorHeight: 24,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 201, 201, 201),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          40.height,
          Center(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF007FCD),
                    Color(0xFF004CCC),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Campo senha vazio'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  await widget.authenticate(_passwordController.text);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          40.height,
        ],
      ),
    );
  }
}
