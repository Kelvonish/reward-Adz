import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/local%20storage/userPreference.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/addAccountDetails.dart';
import 'package:rewardadz/presentation/screens/landingpage.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/providers/topAdvertisersProvider.dart';

import 'package:rewardadz/presentation/screens/navigator.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        Colors.white, // navigation bar color // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your applicationn

  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future<UserModel> getUserData() => UserPreferences().getUser();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TogglePasswordProvider>(
              create: (_) => TogglePasswordProvider()),
          ChangeNotifierProvider<TopAdvertisersProvider>(
            create: (_) => TopAdvertisersProvider(),
          ),
          ChangeNotifierProvider<GetCampaignProvider>(
              create: (_) => GetCampaignProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color.fromRGBO(16, 49, 170, 1),
              accentColor: Color.fromRGBO(213, 225, 255, 1),
              highlightColor: const Color.fromRGBO(114, 145, 219, 1),
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Scaffold(
                      body: Center(
                        child: SpinKitChasingDots(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  default:
                    if (snapshot.data == null)
                      return LandingPage();
                    else if (snapshot.data.data.dob == null ||
                        snapshot.data.data.lname == null ||
                        snapshot.data.data.fname == null ||
                        snapshot.data.data.gender == null) {
                      return AddAccountDetails(
                        user: snapshot.data,
                      );
                    } else
                      return BottomNavigator();
                }
              }),
        ));
  }
}
