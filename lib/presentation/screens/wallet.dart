import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/business_logic/providers/transactionProvider.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/presentation/widgets/balanceCardTile.dart';
import 'package:rewardadz/presentation/widgets/transactionTile.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String phoneNumber;
  String countryCode = "254";
  TextEditingController withdrawAmountController = TextEditingController();
  TextEditingController transferPhoneController = TextEditingController();
  TextEditingController transferAmountController = TextEditingController();
  final _withdrawFormKey = GlobalKey<FormState>();
  final _transferFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).getEarnings(
        Provider.of<UserProvider>(context, listen: false).loggedUser);

    Provider.of<TransactionProvider>(context, listen: false).getWithdrawals(
        Provider.of<UserProvider>(context, listen: false).loggedUser);
    Provider.of<TransactionProvider>(context, listen: false).getTransfers(
        Provider.of<UserProvider>(context, listen: false).loggedUser);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAllData() async {
    await Provider.of<TransactionProvider>(context, listen: false).getEarnings(
        Provider.of<UserProvider>(context, listen: false).loggedUser);

    await Provider.of<TransactionProvider>(context, listen: false)
        .getWithdrawals(
            Provider.of<UserProvider>(context, listen: false).loggedUser);
    await Provider.of<TransactionProvider>(context, listen: false).getTransfers(
        Provider.of<UserProvider>(context, listen: false).loggedUser);
  }

  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    _completeWithdrawal(int amount) async {
      Navigator.pop(context);
      bool success =
          await Provider.of<TransactionProvider>(context, listen: false)
              .withdraw(
                  context,
                  Provider.of<UserProvider>(context, listen: false).loggedUser,
                  amount);

      if (success) {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                    child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                )),
                content: Container(
                  width: double.maxFinite,
                  child: Text("Withdrawal completed successfully"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Done',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } else {
        Fluttertoast.showToast(msg: "Withdrawal failed!");
      }
    }

    _showInDevelopmentDialog(BuildContext context) {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                  child: Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
                size: 50,
              )),
              content: Container(
                width: double.maxFinite,
                child: Text("Feature is still in development! coming soon"),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

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
                      child: value.earningsLoading
                          ? Center(
                              child: SpinKitChasingDots(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : value.allEarnings == null
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
                              : value.allEarnings.data.isEmpty
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
                                      itemCount: value.allEarnings.data.length,
                                      itemBuilder: (context, index) {
                                        return TranscationTile(
                                          data: value.allEarnings.data[index],
                                          type:
                                              value.allEarnings.data[index].txn,
                                        );
                                      })),
                  Container(
                      child: value.withdrawsLoading
                          ? Center(
                              child: SpinKitChasingDots(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : value.allWithdrawals == null
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
                              : value.allWithdrawals.data.isEmpty
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
                                      itemCount:
                                          value.allWithdrawals.data.length,
                                      itemBuilder: (context, index) {
                                        return TranscationTile(
                                          data:
                                              value.allWithdrawals.data[index],
                                          type: value
                                              .allWithdrawals.data[index].txn,
                                        );
                                      })),
                  Container(
                      child: value.transfersLoading
                          ? Center(
                              child: SpinKitChasingDots(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : value.allTransfers == null
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
                              : value.allTransfers.data.isEmpty
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
                                      itemCount: value.allTransfers.data.length,
                                      itemBuilder: (context, index) {
                                        return TranscationTile(
                                          data: value.allTransfers.data[index],
                                          type: value
                                              .allTransfers.data[index].txn,
                                        );
                                      })),
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
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        onRefresh: () {
          return getAllData();
        },
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Consumer<UserProvider>(
                builder: (context, value, child) => BalanceCard(
                  name: "Balance",
                  currency: value.loggedUser.data.currency,
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
                                      margin: MediaQuery.of(context).viewInsets,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "Withdraw",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black),
                                            ),
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Make sure the account is registered with a nuber registered with M-pesa",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Divider(
                                            height: 5,
                                          ),
                                          Form(
                                            key: _withdrawFormKey,
                                            child: TextFormField(
                                              validator: (value) =>
                                                  value.isEmpty
                                                      ? "Please Enter Amount"
                                                      : null,
                                              controller:
                                                  withdrawAmountController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "Enter Amount",
                                                  labelStyle: _labelStyle),
                                            ),
                                          ),
                                          Consumer<TransactionProvider>(
                                            builder: (context, value, child) =>
                                                Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.all(0.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_withdrawFormKey
                                                      .currentState
                                                      .validate()) {
                                                    if (withdrawAmountController
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Amount");
                                                    } else {
                                                      if (int.parse(
                                                              withdrawAmountController
                                                                  .text) >
                                                          Provider.of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .loggedUser
                                                              .balance) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "You cannot withdraw more than your balance");
                                                      } else if (int.parse(
                                                              withdrawAmountController
                                                                  .text) <
                                                          66) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Minimum withdraw amount  is Ksh 70");
                                                      } else if (int.parse(
                                                              withdrawAmountController
                                                                  .text) >
                                                          70000) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Maximum amount per transaction is Ksh 70000");
                                                      } else {
                                                        int transactionFees;
                                                        if (int.parse(
                                                                withdrawAmountController
                                                                    .text) <
                                                            1000) {
                                                          transactionFees = 16;
                                                        } else {
                                                          transactionFees = 22;
                                                        }

                                                        int netAmount = int.parse(
                                                                withdrawAmountController
                                                                    .text) -
                                                            transactionFees;
                                                        Navigator.pop(context);
                                                        showDialog<void>(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Center(
                                                                    child: Icon(
                                                                  Icons
                                                                      .info_outline,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 50,
                                                                )),
                                                                content: Container(
                                                                    width: double
                                                                        .maxFinite,
                                                                    child: Text(
                                                                        "You have withdrawn ${withdrawAmountController.text}. You will received ${netAmount.toString()} since ${transactionFees.toString()} is transaction fee")),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).primaryColor)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Withdraw',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).primaryColor)),
                                                                    onPressed:
                                                                        () {
                                                                      _completeWithdrawal(
                                                                          int.parse(
                                                                              withdrawAmountController.text));
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text("Withdraw"),
                                                ),
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0.0),
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
                      _showInDevelopmentDialog(context);
                      /* showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                                margin: EdgeInsets.all(15.0),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Container(
                                      margin: MediaQuery.of(context).viewInsets,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
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
                                            controller: transferPhoneController,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Phone Number",
                                                labelStyle: _labelStyle),
                                            onCountryChanged: (phone) {
                                              countryCode = phone.countryCode;
                                            },
                                          ),
                                          Form(
                                            key: _transferFormKey,
                                            child: TextFormField(
                                              validator: (value) =>
                                                  value.isEmpty
                                                      ? "Please Enter Amount"
                                                      : null,
                                              controller:
                                                  transferAmountController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "Enter Amount",
                                                  labelStyle: _labelStyle),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.all(0.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_transferFormKey
                                                    .currentState
                                                    .validate()) {
                                                  if (transferPhoneController
                                                              .text ==
                                                          null ||
                                                      transferPhoneController
                                                              .text.length <
                                                          6) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please Enter a valid number");
                                                  } else {
                                                    String trimmedCountryCode;
                                                    String trimmedNumber;

                                                    if (countryCode.contains(
                                                        "+", 0)) {
                                                      trimmedCountryCode =
                                                          countryCode.substring(
                                                              1,
                                                              countryCode
                                                                  .length);
                                                    } else {
                                                      trimmedCountryCode =
                                                          countryCode;
                                                    }
                                                    if (transferPhoneController
                                                        .text
                                                        .contains("0", 0)) {
                                                      trimmedNumber =
                                                          transferPhoneController
                                                              .text
                                                              .substring(
                                                                  1,
                                                                  transferPhoneController
                                                                      .text
                                                                      .length);
                                                    } else {
                                                      trimmedNumber =
                                                          transferPhoneController
                                                              .text;
                                                    }
                                                    phoneNumber =
                                                        trimmedCountryCode +
                                                            trimmedNumber;
                                                   
                                                    if (int.parse(
                                                            transferAmountController
                                                                .text) >
                                                        Provider.of<UserProvider>(
                                                                context,
                                                                listen: false)
                                                            .loggedUser
                                                            .balance) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "You cannot transfer more than your balance");
                                                    } else if (int.parse(
                                                            withdrawAmountController
                                                                .text) <
                                                        50) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Minimum transfer amount is 50");
                                                    }
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text("Transfer"),
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
                    */
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
                  InkWell(
                    onTap: () {
                      _showInDevelopmentDialog(context);
                    },
                    child: Column(
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
                  ),
                ],
              ),
              Consumer<TransactionProvider>(
                builder: (context, value, child) => value.withdrawModalLoading
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: SpinKitThreeBounce(
                            size: 35,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              _tabSection(context),
            ],
          ),
        ),
      ),
    );
  }
}
