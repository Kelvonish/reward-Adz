import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdTile extends StatelessWidget {
  final String url;
  final String name;
  AdTile({this.name, this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              url,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
