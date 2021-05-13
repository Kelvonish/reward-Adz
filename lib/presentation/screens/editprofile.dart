import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime _selectedDate = DateTime.now();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    }

    _dateController.text = _formatDate(_selectedDate);
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
                        initialDateTime: DateTime(1998, 3, 20),
                        maximumDate: DateTime(2003, 1, 1),
                        onDateTimeChanged: (DateTime pickedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }),
                  ),
                  CupertinoButton(
                      child: (Text(
                        "Done",
                        style: TextStyle(color: Colors.black),
                      )),
                      onPressed: () {
                        print(_selectedDate);

                        Navigator.of(context).pop();
                      })
                ],
              )));
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
            child: Form(
              child: ListView(
                children: [
                  Center(
                    child: Column(
                      children: [
                        ProfileImage(),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Jane Doe",
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
                    initialValue: "Jane",
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
                    initialValue: "Doe",
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
                    initialValue: "test@test.com",
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
                    onTap: () {
                      _pickDateDialog(context);
                    },
                    readOnly: true,

                    controller: _dateController,
                    //initialValue: DateTime(1998, 3, 20).toString(),

                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Gender",
                    style: _labelStyle,
                  ),
                  TextFormField(
                    enableInteractiveSelection:
                        false, // will disable paste operation
                    enabled: false,
                    controller: TextEditingController()..text = 'Male',
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
                      focusNode: FocusNode(),
                      enabled: false,
                      enableInteractiveSelection:
                          false, // will disable paste operation
                      readOnly: true,
                      controller: TextEditingController()
                        ..text = '254789345123',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration()),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Save"),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
