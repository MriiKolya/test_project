import 'package:testproject/features/adding_house/view/adding_house.dart';
import 'package:testproject/features/main/view/main_screen.dart';
import 'package:testproject/features/floors/view/floors_screen.dart';

class AppRouter {
  static const String mainRoute = '/';
  static const String houseAddingRoute = '/houseAdd';
  static const String vacantApartmentsRoute = '/floors';
}

final router = {
  '/': (context) => const MainScreen(),
  '/houseAdd': (context) => const HouseAddingScreen(),
  '/floors': (context) => const FloorsScreen(),
};
