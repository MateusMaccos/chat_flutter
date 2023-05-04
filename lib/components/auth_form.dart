import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                    Theme.of(context).primaryColor.withBlue(255)),
                backgroundColor:
                    MaterialStatePropertyAll(Theme.of(context).primaryColor),
              ),
              onPressed: () {},
              child: const Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Criar nova conta?"),
            )
          ],
        )),
      ),
    );
  }
}
