import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/login/sign_in_page.dart';
import 'package:dreavy/ui/pages/favorite_page.dart';
import 'package:dreavy/ui/pages/home_page.dart';
import 'package:dreavy/ui/pages/not_found_page.dart';
import 'package:dreavy/ui/pages/profile_page.dart';
import 'package:dreavy/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoProvider>(
      create: (context) => UserInfoProvider(),
      child: MaterialApp.router(
        theme: dreavyTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(
          errorBuilder: (_, GoRouterState state) => NotFoundPage(state: state),
          initialLocation: '/login',
          redirect: (context, state) async {
            if (state.location.isEmpty) return '/home';
            // if (!await LoginService.of(context).isLoggedIn) return '/login';
            return null;
          },
          routes: <GoRoute>[
            GoRoute(
                path: '/login',
                builder: (_, GoRouterState state) => SignInPage(state: state)),
            GoRoute(
                path: '/home',
                builder: (_, GoRouterState state) => HomePage(state: state)),
            GoRoute(
                path: '/profile',
                builder: (_, GoRouterState state) => ProfilePage(state: state)),
            GoRoute(
                path: '/favorites',
                builder: (_, GoRouterState state) => FavoritePage(state: state)),
          ],
        ),
      ),
    );
  }
}
