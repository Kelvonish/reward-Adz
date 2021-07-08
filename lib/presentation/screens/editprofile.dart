import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
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

    uploadImage(BuildContext context) async {
      Navigator.pop(context);
      if (_imageFile != null) {
        Provider.of<UserProvider>(context, listen: false).uploadProfileImage(
            _imageFile.path,
            Provider.of<UserProvider>(context, listen: false).loggedUser);
      } else {
        Fluttertoast.showToast(msg: "Please select image");
      }
    }

    Future<bool> _requestPermission(Permission permission) async {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      }
      return false;
    }

    _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );

        _imageFile = pickedFile;
        await uploadImage(context);
      } catch (e) {
        setState(() {
          _pickImageError = e;
          print(_pickImageError);
        });
      }
    }

    _selectSource(BuildContext context) async {
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
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            await _onImageButtonPressed(ImageSource.gallery,
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
                        Divider(
                          height: 5,
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
                        Divider(
                          height: 5,
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
                            onTap: () async {
                              if (Platform.isIOS) {
                                if (await _requestPermission(
                                    Permission.photos)) {
                                  await _selectSource(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Permission not granted! Please go to settings and allow permission to access all photos");
                                }
                              } else {
                                if (await _requestPermission(
                                    Permission.storage)) {
                                  await _selectSource(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Permission not granted");
                                  return false;
                                }
                              }
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
                          SizedBox(
                            height: 5.0,
                          ),
                          value.uploadingImage
                              ? Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: SpinKitThreeBounce(
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              : SizedBox()
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
                      controller: _dateController
                        ..text = value.loggedUser.data.dob,
                      keyboardType: TextInputType.datetime,
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
