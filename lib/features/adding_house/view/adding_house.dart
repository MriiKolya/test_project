import 'package:flutter/material.dart';
import 'package:testproject/config/router/router.dart';
import 'package:testproject/core/widgets/add_house.dart';
import 'package:testproject/features/data/sqlite/sqlite_db.dart';
import 'package:testproject/features/models/house_model.dart';
import 'package:testproject/features/models/submit_model.dart';

class HouseAddingScreen extends StatefulWidget {
  const HouseAddingScreen({super.key});

  @override
  State<HouseAddingScreen> createState() => _HouseAddingScreenState();
}

class _HouseAddingScreenState extends State<HouseAddingScreen> {
  Future<List<HouseModel>>? houseList;
  final sqliteDb = SqliteDb();

  @override
  void initState() {
    fetchHouse();
    super.initState();
  }

  // Method to fetch the list of houses from the SQLite database
  void fetchHouse() {
    setState(() {
      houseList = sqliteDb.getHouseList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            children: [
              const SizedBox(height: 80),
              FilledButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AddHouseAlert(
                              // Callback when house is submitted
                              onSubmit: (SubmitHouse house) async {
                                await sqliteDb.addHouse(house);
                                if (!mounted) return;
                                Navigator.of(context).pop();
                                fetchHouse();
                              },
                            ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add house',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.add,
                        size: 35,
                      )
                    ],
                  )),
              const SizedBox(height: 30),
              FutureBuilder(
                future: houseList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<HouseModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const Center(child: CircularProgressIndicator());
                  } else {
                    final listhouse = snapshot.data!;
                    return listhouse.isEmpty
                        ? Center(
                            child: Text(
                            'table is empty :( ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ))
                        : Expanded(
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AppRouter.vacantApartmentsRoute,
                                          arguments: listhouse[index]);
                                    },
                                    child: ListTile(
                                      leading: const Text('House'),
                                      trailing: Text(listhouse[index].name),
                                      title:
                                          Text(listhouse[index].id.toString()),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 12);
                                },
                                itemCount: listhouse.length),
                          );
                  }

                  return Center(
                    child: Text(
                      'Error',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
