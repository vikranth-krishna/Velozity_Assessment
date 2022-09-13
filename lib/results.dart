import 'package:velozity_assesment/patient.dart';
import 'package:velozity_assesment/patientservice.dart';
import 'package:velozity_assesment/user.dart';
import 'package:velozity_assesment/userservice.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import './pdfroute.dart';

class results extends StatefulWidget {
  final int id;
  const results({Key? key, required this.id}) : super(key: key);

  @override
  State<results> createState() => _resultsState();
}

class _resultsState extends State<results> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  var _patientService = PatientService();
  var id;
  int? c;
  String name = "";
  String p_id = "";
  String mail = "";
  String age = "";
  String gender = "";
  String mstats = "";
  String hand = "";
  String finger = "";
  String foot = "";
  String arm = "";
  String leg = "";
  String neck = "";
  String back = "";
  late List<patient> _patientList;

  getall() async{
    var users = await _patientService.readAllPatient();
    _patientList = <patient>[];
    users.forEach((user) {
      setState(() {
        var usermodel = patient();
        usermodel.id = user['id'];
        usermodel.patientid = user['patientid'];
        usermodel.patientname = user['patientname'];
        usermodel.patientemail = user['patientemail'];
        usermodel.patientage = user['patientage'];
        usermodel.patientgender = user['patientgender'];
        usermodel.patientmaritalstatus = user['patientmaritalstatus'];
        usermodel.hand = user['hand'];
        usermodel.finger = user['finger'];
        usermodel.foot = user['foot'];
        usermodel.arm = user['arm'];
        usermodel.leg = user['leg'];
        usermodel.neck = user['neck'];
        usermodel.back = user['back'];
        _patientList.add(usermodel);
      });
      id = widget.id;
      c = id - 1;

      Future.delayed(const Duration(milliseconds: 500), () async {
        setState(() {
          p_id = _patientList[c!].patientid!;
          name = _patientList[c!].patientname!;
          mail = _patientList[c!].patientemail!;
          age = _patientList[c!].patientage!;
          gender = _patientList[c!].patientgender!;
          mstats = _patientList[c!].patientmaritalstatus!;
          hand = _patientList[c!].hand!;
          finger = _patientList[c!].finger!;
          foot = _patientList[c!].foot!;
          arm = _patientList[c!].arm!;
          leg = _patientList[c!].leg!;
          neck = _patientList[c!].neck!;
          back = _patientList[c!].back!;
        });
      });
    });

    var resultall = await _patientService.readAllPatient();
    print(resultall);




  }



  // getAllDetails() async {
  //   var users = await _userService.readAllUser();
  //   _userList = <user>[];
  //   users.forEach((users) {
  //     setState(() {
  //       var userModel = user();
  //       userModel.id = users['id'];
  //       userModel.name = users['name'];
  //       userModel.email = users['email'];
  //       userModel.hand = users['hand'];
  //       userModel.finger = users['finger'];
  //       userModel.foot = users['foot'];
  //       userModel.arm = users['arm'];
  //       userModel.leg = users['leg'];
  //       userModel.neck = users['neck'];
  //       userModel.back = users['back'];
  //
  //       _userList.add(userModel);
  //     });
  //   });
  //
  //
  //   setState(() {
  //     name = _userList[0].name!;
  //     email = _userList[0].email!;
  //     hand = _userList[1].hand!;
  //     finger = _userList[2].finger!;
  //     foot = _userList[3].foot!;
  //     arm = _userList[4].arm!;
  //     leg = _userList[5].leg!;
  //     neck = _userList[6].neck!;
  //     back = _userList[7].back!;
  //   });
  // }

  @override
  void initState() {
    getall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Done!",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "PDF created Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Click share to share your overall data",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: GestureDetector(

                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                onTap: _createpdf,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _createpdf() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();
    page.graphics.drawString(
        'Results', PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawImage(
        PdfBitmap(await _readImage('feetwingsonboard1.jpg')),
        Rect.fromLTRB(0, 100, 440, 550));

    PdfGrid grid = PdfGrid();
    // grid.style = PdfGridStyle(
    //   font: PdfStandardFont(PdfFontFamily.helvetica, 30),
    //   // cellPadding: PdfPaddings(left: , right: 2, top: 2, bottom: 2)
    // );
    grid.columns.add(count: 8);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Name';
    header.cells[1].value = 'Hand Grip';
    header.cells[2].value = 'Finger Strength';
    header.cells[3].value = 'Foot Strength';
    header.cells[4].value = 'Arm Strength';
    header.cells[5].value = 'Leg Strength';
    header.cells[6].value = 'Neck Strength';
    header.cells[7].value = 'Back Strength';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '$name';
    row.cells[1].value = "$hand Kg";
    row.cells[2].value = '$finger Kg';
    row.cells[3].value = '$foot Kg';
    row.cells[4].value = '$arm Kg';
    row.cells[5].value = '$leg Kg';
    row.cells[6].value = '$neck Kg';
    row.cells[7].value = '$back Kg';

    row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = '5Kg';
    row.cells[2].value = '10Kg';
    row.cells[3].value = '10Kg';
    row.cells[4].value = '10Kg';
    row.cells[5].value = '10Kg';
    row.cells[6].value = '10Kg';
    row.cells[7].value = '10Kg';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = '5Kg';
    row.cells[2].value = '10Kg';
    row.cells[3].value = '10Kg';
    row.cells[4].value = '10Kg';
    row.cells[5].value = '10Kg';
    row.cells[6].value = '10Kg';
    row.cells[7].value = '10Kg';

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTRB(0, 0, 0, 0));



    var bytes = document.save();

    saveandlaunchfile(bytes, 'Output.pdf');

    document.dispose();
  }
}

Future<Uint8List> _readImage(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
