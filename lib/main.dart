import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/providers/participateCampaign.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/database/campaignDatabase.dart';
import 'package:rewardadz/data/local storage/locationPreference.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/addAccountDetails.dart';
import 'package:rewardadz/presentation/screens/landingpage.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/providers/topAdvertisersProvider.dart';
import 'package:rewardadz/business_logic/providers/authenticationProvider.dart';
import 'package:rewardadz/business_logic/providers/transactionProvider.dart';
import 'package:rewardadz/presentation/screens/navigator.dart';
import 'presentation/screens/account Creation/verifyOtp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your applicationn

  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDeviceRooted = false;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    await LocationPreference().saveLocation();
  }

  @override
  Widget build(BuildContext context) {
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
          ChangeNotifierProvider<AuthenticationProvider>(
              create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider<CampaignDatabaseProvider>(
              create: (_) => CampaignDatabaseProvider()),
          ChangeNotifierProvider<TransactionProvider>(
              create: (_) => TransactionProvider()),
          ChangeNotifierProvider<ParticipateCampaignProvider>(
              create: (_) => ParticipateCampaignProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color.fromRGBO(16, 49, 170, 1),
              accentColor: Color.fromRGBO(213, 225, 255, 1),
              highlightColor: const Color.fromRGBO(114, 145, 219, 1),
              scaffoldBackgroundColor: Colors.white),
          home: CheckSession(),
        ));
  }
}

class CheckSession extends StatefulWidget {
  @override
  _CheckSessionState createState() => _CheckSessionState();
}

class _CheckSessionState extends State<CheckSession> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        child: FutureBuilder(
            future: Provider.of<UserProvider>(context, listen: false)
                .getLoggedInUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Scaffold(
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            const Color.fromRGBO(114, 145, 219, 1),
                            Theme.of(context).accentColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: SpinKitChasingDots(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                default:
                  if (snapshot.data == null) {
                    return LandingPage();
                  } else if (snapshot.data.data.dob == null ||
                      snapshot.data.data.lname == null ||
                      snapshot.data.data.fname == null ||
                      snapshot.data.data.gender == null) {
                    return AddAccountDetails(
                      user: snapshot.data,
                    );
                  } else if (snapshot.data.data.status == 5) {
                    return VerifyOtp(user: snapshot.data);
                  } else if (Provider.of<UserProvider>(context, listen: false)
                      .expiryTime
                      .isBefore(DateTime.now())) {
                    Fluttertoast.showToast(
                        msg: "Session expired! Please Login again");
                    return LandingPage();
                  } else {
                    return BottomNavigator();
                  }
              }
            }),
      ),
    );
  }
}
