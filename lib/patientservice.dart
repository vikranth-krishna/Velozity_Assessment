import './patient.dart';
import './repository.dart';

class PatientService{
  late Repository _repository;
  PatientService() {
    _repository = Repository();
  }
  SavePatient(patient p) async{
    return await _repository.insertData("patient", p.patientMap());
  }
  readAllPatient() async{
    return await _repository.readData("patient");
  }
  UpdatePatient(patient p) async{
    return await _repository.updateData("patient", p.patientMap());
  }
}