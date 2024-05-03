import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:usp_ecard/core/routes/app_router.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';
import 'package:usp_ecard/core/service/injections/injection.dart';

Future<bool> initialize() async {
  await Injections.start();
  await GetIt.I.allReady();
  return true;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FutureBuilder(
    future: initialize(),
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  width: 124,
                  height: 124,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/lauch.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return const BuildApp();
    },
  ));
}

class BuildApp extends StatefulWidget {
  const BuildApp({super.key});

  @override
  State<BuildApp> createState() => _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      title: 'E-CARD USP',
      initialRoute: AppRoutes.login,
    );
  }
}
