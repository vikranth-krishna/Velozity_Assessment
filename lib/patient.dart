class patient {
  int? id;
  String? patientid;
  String? patientname;
  String? patientemail;
  String? patientage;
  String? patientgender;
  String? patientmaritalstatus;
  String? hand;
  String? finger;
  String? foot;
  String? arm;
  String? leg;
  String? neck;
  String? back;

  patientMap() {
    var mapping = Map<String, dynamic>();
    mapping['id']=id??null;
    mapping['patientid'] = patientid;
    mapping['patientname'] = patientname;
    mapping['patientemail'] = patientemail;
    mapping['patientage'] = patientage;
    mapping['patientgender'] = patientgender;
    mapping['patientmaritalstatus'] = patientmaritalstatus;
    mapping['hand'] = hand;
    mapping['finger'] = finger;
    mapping['foot'] = foot;
    mapping['arm'] = arm;
    mapping['leg'] = leg;
    mapping['neck'] = neck;
    mapping['back'] = back;
    return mapping;
  }
}
