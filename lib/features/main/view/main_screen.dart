import 'package:flutter/material.dart';
import 'package:testproject/config/router/router.dart';
import 'package:testproject/features/constant/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Text(
                  'Test Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.red),
                  color: boxColor,
                ),
                child: Image.network(
                  imagePhotoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.houseAddingRoute);
                  },
                  child: const Text('Enter')),
              const Spacer(),
              const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'desinged by ...',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
