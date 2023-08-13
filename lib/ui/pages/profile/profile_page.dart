import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SizedBox(height: 50.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'faculdade',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'curso',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'data final. mes/ano',
            ),
          ),
          const SizedBox(height: 50.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Center(child: Text('Salvar')),
          )
        ],
      ),
    );
  }
}
