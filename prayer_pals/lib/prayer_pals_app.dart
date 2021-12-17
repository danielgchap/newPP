import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/group/view/admin_members_page.dart';
import 'features/group/view/group_search_page.dart';
import 'features/home/view/home_page.dart';
import 'features/home/view/home_page_container.dart';
import 'features/prayer/view/pray_now_page.dart';
import 'features/user/providers/auth_providers.dart';
import 'features/user/view/login_page.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(authStateProvider);
    return MaterialApp(
      routes: {
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => HomePage(),
        '/PrayNowPage': (context) => PrayNowPage(),
        '/GroupSearchPage': (context) => GroupSearchPage(),
        '/AdminMembersPage': (context) => AdminMembersPage(),
        // '/Activity': (context) => Activity(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[200],
        backgroundColor: Colors.white,
        fontFamily: 'OpenSans',
        hintColor: Colors.white,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              headline6:
                  TextStyle(height: 2.0, fontSize: 30.0, color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: _authState.when(data: (data) {
        if (data != null) {
          return const HomePageContainer();
        }
        return LoginPage();
      }, loading: () {
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      }, error: (object, trace) {
        return LoginPage();
      }),
    );
  }
}
