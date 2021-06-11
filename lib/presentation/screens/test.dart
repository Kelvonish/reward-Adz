// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

//import 'image_previews.dart';

class DemoApp extends StatefulWidget {
  final String id;
  DemoApp({this.id});
  @override
  DemoAppState createState() => DemoAppState();
}

class DemoAppState extends State<DemoApp> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Plugin Demo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Share Plugin Demo'),
          ),
          body: Container(
            child: Text("rightPlace"),
          )),
    );
  }
}
