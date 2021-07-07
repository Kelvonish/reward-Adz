import 'package:flutter/material.dart';
import 'package:rewardadz/business_logic/providers/dynamicLinksProvider.dart';
import 'package:rewardadz/presentation/screens/homepage.dart';
import 'package:rewardadz/presentation/screens/profile.dart';
import 'package:rewardadz/presentation/screens/report.dart';
import 'package:rewardadz/presentation/screens/search.dart';
import 'package:rewardadz/presentation/screens/wallet.dart';
import 'package:rewardadz/icons/icons.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int activeIndex = 2;

  @override
  void initState() {
    super.initState();
    handleDynamicLink();
  }

  handleDynamicLink() async {
    await DynamicLinkService(context: context).handleDynamicLinks();
  }

  var iconData = <IconData>[
    Icons.bar_chart_outlined,
    Icons.search,
    MyFlutterApp.ra_logo__1_,
    Icons.account_balance_wallet_outlined,
    Icons.person_outline
  ];

  void _onTap(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var indicatorColors = <Color>[Theme.of(context).primaryColor];
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
            body: IndexedStack(
              index: activeIndex,
              children: [Report(), Search(), MyHomePage(), Wallet(), Profile()],
            ),
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: RollingNavBar.iconData(
                activeBadgeColors: <Color>[
                  Colors.white,
                ],
                activeIconColors: [Colors.white],
                activeIndex: activeIndex,

                animationCurve: Curves.linear,
                animationType: AnimationType.roll,
                baseAnimationSpeed: 100,
                indicatorSides: 20,
                //badges: badgeWidgets,
                iconData: iconData,
                iconColors: <Color>[Colors.grey[400]],

                indicatorColors: indicatorColors,
                iconSize: 25,
                indicatorRadius: 30,

                onTap: _onTap,
              ),
            )),
      ),
    );
  }
}
