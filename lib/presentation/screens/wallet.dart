import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/business_logic/providers/transactionProvider.dart';
import 'package:rewardadz/presentation/widgets/balanceCardTile.dart';
import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/presentation/widgets/transactionTile.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    Widget _tabSection(BuildContext context) {
      return DefaultTabController(
        length: 3,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black38,
                  tabs: [
                    Tab(text: "Earning"),
                    Tab(text: "Withdrawals"),
                    Tab(text: "Transfers"),
                  ]),
            ),
            Consumer<TransactionProvider>(
              builder: (context, value, child) => Container(
                //Add this to give height
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(children: [
                  Container(
                      child: FutureBuilder(
                          future: value.getEarnings(
                              Provider.of<UserProvider>(context, listen: false)
                                  .loggedUser
                                  .data
                                  .id
                                  .toString()),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: SpinKitChasingDots(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );
                              default:
                                if (snapshot.hasData) {
                                  TransactionModel earnings = snapshot.data;
                                  return earnings.data.length == 0
                                      ? Column(
                                          children: [
                                            Image.asset("assets/earnings.png"),
                                            Text(
                                              "All earnings will appear here",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: earnings.data.length,
                                          itemBuilder: (context, index) {
                                            return TranscationTile(
                                              data: earnings.data[index],
                                              type: earnings.data[index].txn,
                                            );
                                          });
                                }
                            }
                          })),
                  Container(
                    child: FutureBuilder(
                        future: value.getWithdrawals(
                            Provider.of<UserProvider>(context, listen: false)
                                .loggedUser
                                .data
                                .id
                                .toString()),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(
                                child: SpinKitChasingDots(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            default:
                              if (snapshot.hasData) {
                                TransactionModel withdrawals = snapshot.data;
                                return withdrawals.data.length == 0
                                    ? Column(
                                        children: [
                                          Image.asset("assets/withdraw.png"),
                                          Text(
                                            "All withdrawals will appear here",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: withdrawals.data.length,
                                        itemBuilder: (context, index) {
                                          return TranscationTile(
                                            data: withdrawals.data[index],
                                            type: withdrawals.data[index].txn,
                                          );
                                        });
                              }
                          }
                        }),
                  ),
                  Container(
                    child: FutureBuilder(
                        future: value.getTransfers(
                            Provider.of<UserProvider>(context, listen: false)
                                .loggedUser
                                .data
                                .id
                                .toString()),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(
                                child: SpinKitChasingDots(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            default:
                              if (snapshot.hasData) {
                                TransactionModel transfers = snapshot.data;
                                return transfers.data.length == 0
                                    ? Column(
                                        children: [
                                          Image.asset("assets/transfers.png"),
                                          Text(
                                            "All transfers will appear here",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: transfers.data.length,
                                        itemBuilder: (context, index) {
                                          return TranscationTile(
                                            data: transfers.data[index],
                                            type: transfers.data[index].txn,
                                          );
                                        });
                              }
                          }
                        }),
                  ),
                ]),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'My Wallet',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Consumer<UserProvider>(
              builder: (context, value, child) => BalanceCard(
                name: "Balance",
                earnedAmount: value.loggedUser.balance.toString(),
                numberOfAds: value.loggedUser.earnedads.toString(),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                              margin: EdgeInsets.all(15.0),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                    height: 158,
                                    margin: MediaQuery.of(context).viewInsets,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Withdraw",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black),
                                          ),
                                        )),
                                        Divider(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "Enter Amount",
                                              labelStyle: _labelStyle),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.all(0.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text("Withdraw"),
                                            ),
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0.0),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          0.0,
                                                        ),
                                                        side: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .primaryColor)),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ));
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Theme.of(context).accentColor,
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Withdraw",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                              margin: EdgeInsets.all(15.0),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                    height: 234,
                                    margin: MediaQuery.of(context).viewInsets,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Transfer",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black),
                                          ),
                                        )),
                                        Divider(
                                          height: 5,
                                        ),
                                        IntlPhoneField(
                                          initialCountryCode: "KE",
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Phone Number",
                                              labelStyle: _labelStyle),
                                          onChanged: (phone) {
                                            print(phone.completeNumber);
                                          },
                                          onCountryChanged: (phone) {
                                            print('Country code changed to: ' +
                                                phone.countryCode);
                                          },
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "Enter Amount",
                                              labelStyle: _labelStyle),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.all(0.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text("Withdraw"),
                                            ),
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0.0),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          0.0,
                                                        ),
                                                        side: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .primaryColor)),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ));
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Theme.of(context).accentColor,
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Transfer",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Icon(
                        Icons.phone_iphone_outlined,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Buy Airtime",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
            _tabSection(context),
          ],
        ),
      ),
    );
  }
}
