import 'package:flutter/material.dart';

class MainCardTile extends StatelessWidget {
  final String mainUrl;
  final String otherUrl;
  final String name;
  final String category;
  final String amount;
  final String type;

  MainCardTile(
      {this.mainUrl,
      this.otherUrl,
      this.name,
      this.category,
      this.amount,
      this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Container(
            height: 200,
            child: Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Earn Ksh $amount",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Icon(
                            Icons.offline_bolt,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15.0),
                  color: Colors.black38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              otherUrl,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                category,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            type,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: NetworkImage(mainUrl),
                  fit: BoxFit.fitWidth,
                )),
          ),
        ],
      ),
    );
  }
}
