import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/core/routing/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Portal",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Learn for Earth: Every quiz makes a difference",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go(homePage);
                  },
                  child: const Text('Get Started'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
