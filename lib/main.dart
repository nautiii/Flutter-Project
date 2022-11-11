import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/theme.dart';
import 'package:dreavy/ui/login/sign_in_page.dart';
import 'package:dreavy/ui/pages/favorite_page.dart';
import 'package:dreavy/ui/pages/home_page.dart';
import 'package:dreavy/ui/pages/not_found_page.dart';
import 'package:dreavy/ui/pages/profile_page.dart';
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
      create: (BuildContext context) => UserInfoProvider(),
      child: Consumer<UserInfoProvider>(
        builder: (_, UserInfoProvider userInfo, __) => MaterialApp.router(
          theme: dreavyTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: GoRouter(
            errorBuilder: (_, GoRouterState s) => NotFoundPage(state: s),
            redirect: (BuildContext context, GoRouterState state) async {
              if (!userInfo.isLogged) return '/login';
              print('############ redirect');
              return null;
            },
            routes: <GoRoute>[
              GoRoute(
                path: '/',
                builder: (_, GoRouterState s) => HomePage(state: s),
              ),
              GoRoute(
                path: '/home',
                builder: (_, GoRouterState s) => HomePage(state: s),
              ),
              GoRoute(
                path: '/login',
                builder: (_, GoRouterState s) => SignInPage(state: s),
              ),
              GoRoute(
                path: '/profile',
                builder: (_, GoRouterState s) => ProfilePage(state: s),
              ),
              GoRoute(
                path: '/favorites',
                builder: (_, GoRouterState s) => FavoritePage(state: s),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
