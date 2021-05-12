import 'package:flutter/material.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/presentation/screens/landingpage.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/providers/topAdvertisersProvider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your applicationn

  const MyApp();

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color.fromRGBO(16, 49, 170, 1),
            accentColor: Color.fromRGBO(213, 225, 255, 1),
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white),
        home: LandingPage(),
      ),
    );
  }
}
