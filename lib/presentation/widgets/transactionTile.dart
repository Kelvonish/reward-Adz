import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rewardadz/data/models/transactionModel.dart';

class TranscationTile extends StatelessWidget {
  final TransactionData data;
  final String type;
  TranscationTile({this.data, this.type});
  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      return DateFormat("y MMMM d , h:mm a").format(date);
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).accentColor,
                  child: type == "credit"
                      ? Icon(
                          Icons.monetization_on_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        )
                      : Icon(
                          Icons.reply,
                          color: Colors.red,
                          size: 25,
                        )),
              SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      data.naration,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _formatDate(DateTime.parse(data.createdAt)),
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Ksh " + data.amount.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
