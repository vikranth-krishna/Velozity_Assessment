

import 'package:velozity_assesment/handgrip.dart';
import 'package:velozity_assesment/patient.dart';
import 'package:velozity_assesment/patientservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';


class formfill extends StatefulWidget {
  Device device;
 formfill({Key? key, required this.device}) : super(key: key);

  @override
  State<formfill> createState() => _formfillState();
}

class _formfillState extends State<formfill> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();
  String _name = '';
  String _id = '';
  String _email = '';
  int _age = -1;
  String? _maritalStatus;
  int? _selectedGender;
  List<DropdownMenuItem<int>> genderList = [];
  var _patientService = PatientService();

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }


  @override
  Widget build(BuildContext context) {
    loadGenderList();
    return Scaffold(
      appBar: AppBar(title: Text('Enter The Details')),
      body: Form(
          key: _formKey,
          child: ListView(
            children: getFormWidget(),
          )),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'ID for Ref', hintText: 'ID Ref'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Patient ID';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _id = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'Name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validateEmail(String? value) {
      if (value!.isEmpty) {
        return 'Please enter mail';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Email';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) {
        setState(() {
          _email = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter age';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _age = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Single'),
          value: 'single',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Married'),
          value: 'married',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
      ],
    ));

    formWidget.add(ElevatedButton(
        child: const Text('Start Test'), onPressed: ()async{
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        print("Name " + _name);
        print("Email " + _email);
        print("Age " + _age.toString());
        switch (_selectedGender) {
          case 0:
            print("Gender Male");
            break;
          case 1:
            print("Gender Female");
            break;
          case 3:
            print("Gender Others");
            break;
        }
        print("Marital Status " + _maritalStatus!);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));

      }
      var _patient = patient();
      _patient.patientid = _id;
      _patient.patientname = _name;
      _patient.patientemail = _email;
      _patient.patientage = _age.toString();
      if(_selectedGender == 0){
        _patient.patientgender = "male";
      }
      if(_selectedGender == 1){
        _patient.patientgender = "female";
      }
      if(_selectedGender == 2){
        _patient.patientgender = "others";
      }
      _patient.patientmaritalstatus = _maritalStatus;
      _patient.hand = "NA";
      _patient.finger = "NA";
      _patient.foot = "NA";
      _patient.arm = "NA";
      _patient.leg = "NA";
      _patient.neck = "NA";
      _patient.back = "NA";
      var result = await _patientService.SavePatient(_patient);
      print(result);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HgS(device: widget.device, id: result,),
          ));

    }));



    return formWidget;
  }

}
