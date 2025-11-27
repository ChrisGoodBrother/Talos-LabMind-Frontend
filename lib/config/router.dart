import 'package:auto_route/auto_route.dart';
import 'package:lab_mind_frontend/config/router.gr.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: "/home",
      initial: true,
    ),
  ];
}
