import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usp_ecard/core/routes/app_router.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';
import 'package:usp_ecard/core/service/active_application/active_application_service.dart';
import 'package:usp_ecard/core/service/active_application/active_application_service_interface.dart';

void main() {
  runApp(const Build());
}

class Build extends StatefulWidget {
  const Build({super.key});

  @override
  State<Build> createState() => _BuildState();
}

class _BuildState extends State<Build> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      title: 'E-CARD USP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late IActiveApplicationService _activationService;
  bool hasActive = false;

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1)).then((value) async {
      _activationService = ActivationService(await _getSharedPreferences());
    }).then((value) async => await _activationService.isActivated()
        ? Navigator.of(context).pushNamed(AppRoutes.home)
        : await _activationService.activeApplication('1234567890'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.deepPurple,
        child: Stack(
          children: [
            hasActive
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Digite a chave de ativação',
                        ),
                        onFieldSubmitted: (value) async {
                          await _activationService
                              .activeApplication(value)
                              .then((value) => value ? Navigator.of(context).pushNamed(AppRoutes.home) : null);
                        },
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    left: 1,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            hasActive = true;
                          });
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
