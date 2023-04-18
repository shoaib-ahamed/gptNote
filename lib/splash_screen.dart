import 'package:flutter/material.dart';
import 'package:gptNote/screens/auth/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Welcome to chatGPT"),
          const SizedBox(height: 20, width: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("Login")),
          // ElevatedButton(onPressed: onPressed, child: child)
        ],
      ),
    );
  }
}
