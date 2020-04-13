import 'package:country_code_picker/country_localizations.dart';
import 'package:covid19/covid.dart';
import 'package:covid19/features/home/domain/providers/country_provider.dart';
import 'package:covid19/features/intro/presentation/screens/intro_screen.dart';
import 'package:covid19/features/location/domain/location_provider.dart';
import 'package:covid19/features/location/domain/marker_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:covid19/features/home/presentation/screens/feeds_screen.dart';

import 'features/home/domain/providers/firebase_auth_provider.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/registration':
        return MaterialPageRoute(builder: (_) => FeedScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      //removes android status bar
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor:
              Colors.transparent.withOpacity(0.7))),

      runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => CountryProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => MarkerProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ], child: MyApp()))
    };

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseUser user;
  Future<FirebaseUser> getSignedInUser() async {
    var firebaseAuth = FirebaseAuth.instance;
    user = await firebaseAuth.currentUser();
    if (user != null) {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.setCurrentUser(user);
    }
    return user;
  }

  @override
  void initState() {
    precacheImage(Image.asset('assets/images/intro.png').image, context);
    precacheImage(Image.asset('assets/images/queue.png').image, context);
    precacheImage(Image.asset('assets/images/washhands.png').image, context);
    precacheImage(Image.asset('assets/images/workfromhome.png').image, context);
    precacheImage(Image.asset('assets/images/feeling.png').image, context);
    precacheImage(Image.asset('assets/images/helpdoctor.png').image, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.setAnalyticsCollectionEnabled(true);
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      onGenerateRoute: Router.generateRoute,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: new FutureBuilder<FirebaseUser>(
          future: getSignedInUser(),
          builder:
              (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
              case ConnectionState.waiting:
                return Container();
              default:
                if (snapshot.data == null)
                  return IntroScreen();
                else
                  return CovidPage();
            }
          },
        )),
      ),
    );
  }
}
