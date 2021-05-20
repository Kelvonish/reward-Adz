import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/presentation/screens/account Creation/verifyOtp.dart';

class AddAccountDetails extends StatefulWidget {
  final UserModel user;
  AddAccountDetails({this.user});
  @override
  _AddAccountDetailsState createState() => _AddAccountDetailsState();
}

class _AddAccountDetailsState extends State<AddAccountDetails> {
  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);
  List<String> genders = ["Male", "Female", "Other"];
  var _selectedGender;
  var _selectedDate;
  final _dateController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    }

    void _pickDateDialog(BuildContext context) {
      showCupertinoModalPopup(
          barrierDismissible: false,
          context: context,
          builder: (context) => Container(
              color: Colors.white,
              height: 250,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                        use24hFormat: false,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(2003, 1, 1),
                        maximumDate: DateTime(2003, 12, 31),
                        minimumDate: DateTime(1980, 1, 1),
                        onDateTimeChanged: (DateTime pickedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                            _dateController.text = _formatDate(_selectedDate);
                          });
                        }),
                  ),
                  CupertinoButton(
                      child: (Text(
                        "Done",
                        style: TextStyle(color: Colors.black),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              )));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).highlightColor,
                Theme.of(context).accentColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: TextFormField(
                                    controller: _fNameController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please enter first name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "First Name",
                                        labelStyle: _labelStyle),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: TextFormField(
                                    controller: _lNameController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Please enter last name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "Last Name",
                                        labelStyle: _labelStyle),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          DropdownButtonFormField(
                            items: genders.map((String gender) {
                              return new DropdownMenuItem(
                                  value: gender, child: Text(gender));
                            }).toList(),
                            onChanged: (newValue) {
                              // do other stuff with _category
                              setState(() => _selectedGender = newValue);
                            },
                            validator: (val) =>
                                val == null ? "Please select gender" : null,
                            value: _selectedGender,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Gender",
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          TextFormField(
                            enableInteractiveSelection: false,
                            validator: (val) => val == null
                                ? "Please select date of birth"
                                : null,
                            onTap: () {
                              _pickDateDialog(context);
                            },
                            readOnly: true,
                            controller: _dateController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15.0),
                              hintStyle: _labelStyle,
                              hintText: "Select date of birth",
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Consumer<UserProvider>(
                      builder: (context, value, child) => value
                              .accountDetailButton
                          ? SpinKitChasingDots(
                              color: Colors.white,
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  DataModel data = DataModel(
                                      dob: _formatDate(_selectedDate),
                                      fname: _fNameController.text,
                                      lname: _lNameController.text,
                                      gender: _selectedGender,
                                      id: widget.user.data.id);

                                  UserModel user = UserModel(data: data);
                                  value.updateUserDetails(context, user);
                                }
                              },
                              child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Submit"))),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
