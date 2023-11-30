import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testproject/features/constant/constants.dart';
import 'package:testproject/features/data/sqlite/sqlite_db.dart';
import 'package:testproject/features/models/house_model.dart';
import 'package:testproject/features/models/last_house_selected.dart';

class FloorsScreen extends StatefulWidget {
  const FloorsScreen({super.key});

  @override
  State<FloorsScreen> createState() => _FloorsScreenState();
}

class _FloorsScreenState extends State<FloorsScreen> {
  HouseModel? _house;
  // Index of the currently selected floor
  int? _selectedIndex;
  final sqliteDb = SqliteDb();
  // Direction of elevator movement (-1 for down, 1 for up)
  int _direction = 1;
  // Target floor for elevator movement
  int? _moveToFloor;

  void setIndexCurentFloor() {
    _selectedIndex = _house!.listFloor.indexOf(true);
    if (_selectedIndex != -1) {
      _selectedIndex = _selectedIndex! + 1;
    }
  }

  @override
  // Method to set the index of the current floor based on the selected floor in the house
  void didChangeDependencies() {
    setState(() {
      _house ??= ModalRoute.of(context)?.settings.arguments as HouseModel?;
      setIndexCurentFloor();
    });
    super.didChangeDependencies();
  }

  // Method to move the elevator to the target floor
  void moveToFloor(int targetFloor) {
    if (_selectedIndex == targetFloor) {
      // If the elevator is already on the desired floor, do nothing
      return;
    }

    // Determine the direction of motion
    _direction = (_selectedIndex! < targetFloor) ? 1 : -1;

    // Start the timer to move smoothly every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        // Move the elevator by one floor according to the direction
        _selectedIndex = _selectedIndex! + _direction;
        // If the target floor is reached, stop the timer
        if (_selectedIndex == targetFloor) {
          sqliteDb.moveToApart(_house!, targetFloor - 1);
          LastHouseSelected.lastHouseSelected = _house;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    'Floors',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    '${_house?.name} (#${_house?.id})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Divider(thickness: 1, color: Theme.of(context).primaryColor),
              const SizedBox(height: 50),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Color tileColor;
                  if (_selectedIndex == index + 1) {
                    tileColor = colorCurrent; // The elevator is on this floor
                  } else if (_moveToFloor == index + 1) {
                    tileColor = colorMove; // The elevator is moving to this floor
                  } else {
                    tileColor = Colors
                        .transparent; // Floor is not selected and is not a movement target
                  }
                  return SizedBox(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _moveToFloor = index + 1;
                        });
                        moveToFloor(_moveToFloor!);
                      },
                      tileColor: tileColor,
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Floor ${(index + 1).toString()}',
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: _house!.listFloor.length,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
