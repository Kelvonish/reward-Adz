import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/presentation/widgets/profileImage.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextStyle _titleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  TextStyle _labelStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey);
  PickedFile _imageFile;
  dynamic _pickImageError;

  String _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate;
    var _value = Provider.of<UserProvider>(context, listen: false);
    var _formKey = GlobalKey<FormState>();
    TextEditingController _dateController = TextEditingController();

    TextEditingController _emailController = TextEditingController();
    TextEditingController _fnameController =
        TextEditingController(text: _value.loggedUser.data.fname);
    TextEditingController _lnameController =
        TextEditingController(text: _value.loggedUser.data.lname);
    TextEditingController _genderController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();

    String _formatDate(DateTime date) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    }

    void _onImageButtonPressed(ImageSource source,
        {BuildContext context}) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );
        setState(() {
          _imageFile = pickedFile;
          inspect(_imageFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }

    void _selectSource(BuildContext context) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => Material(
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Title(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Upload Profile Image',
                              style: TextStyle(fontSize: 18.0),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 3,
                        ),
                        InkWell(
                          onTap: () {
                            _onImageButtonPressed(ImageSource.gallery,
                                context: context);
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.photo_library,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Select From Gallery"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _onImageButtonPressed(ImageSource.camera,
                                context: context);
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Take a Photo"),
                          ),
                        ),
                      ],
                    )),
              ));
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Consumer<UserProvider>(
              builder: (context, value, child) => Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _selectSource(context);
                            },
                            child: ProfileImage(
                              url: value.loggedUser.data.image,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            value.loggedUser.data.fname +
                                " " +
                                value.loggedUser.data.lname,
                            style: _titleStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "First Name",
                      style: _labelStyle,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "first name cannot be empty " : null,
                      controller: _fnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Last Name",
                      style: _labelStyle,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "last name cannot be empty " : null,
                      controller: _lnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Email Address",
                      style: _labelStyle,
                    ),
                    TextFormField(
                      controller: _emailController
                        ..text = value.loggedUser.data.email,
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Date of Birth",
                      style: _labelStyle,
                    ),
                    TextFormField(
                      enableInteractiveSelection: false,
                      enabled: false,
                      readOnly: true,
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration:
                          InputDecoration(hintText: value.loggedUser.data.dob),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Gender",
                      style: _labelStyle,
                    ),
                    TextFormField(
                      controller: _genderController
                        ..text = value.loggedUser.data.gender,
                      enableInteractiveSelection:
                          false, // will disable paste operation
                      enabled: false,

                      //controller: TextEditingController()..text = ,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Phone Number",
                      style: _labelStyle,
                    ),
                    TextFormField(
                        controller: _phoneController
                          ..text = value.loggedUser.data.phone,
                        focusNode: FocusNode(),
                        enabled: false,
                        enableInteractiveSelection:
                            false, // will disable paste operation
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration()),
                    SizedBox(
                      height: 30,
                    ),
                    value.loginButtonLoading
                        ? Center(
                            child: SpinKitChasingDots(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Save"),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                if (_dateController.text ==
                                        value.loggedUser.data.dob &&
                                    _fnameController.text ==
                                        value.loggedUser.data.fname &&
                                    _lnameController.text ==
                                        value.loggedUser.data.lname) {
                                  Fluttertoast.showToast(
                                      msg: "You have not changed any field!");
                                } else {
                                  DataModel data = DataModel(
                                      email: _emailController.text,
                                      dob: _dateController.text,
                                      fname: _fnameController.text,
                                      lname: _lnameController.text,
                                      phone: _phoneController.text,
                                      gender: _genderController.text,
                                      id: value.loggedUser.data.id);

                                  UserModel user = UserModel(data: data);
                                  value.updateProfile(context, user);
                                }
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
