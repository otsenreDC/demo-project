import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                    "https://is5-ssl.mzstatic.com/image/thumb/Purple111/v4/c1/c0/fc/c1c0fc10-f049-9c7f-f38d-9fd076b0f846/source/256x256bb.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Usuario",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Usuario",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text("Iniciar sesión"),
            ),
            Text("¿Olvidaste tu contraseña?"),
            Text("O"),
            Text("Facebook"),
            Text("Google"),
            Text("Apple"),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Regístrate"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
