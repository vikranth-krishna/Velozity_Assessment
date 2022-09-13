import './user.dart';
import './repository.dart';

class UserService{
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  SaveUser(user p) async{
    return await _repository.insertData("user", p.userMap());
  }
  readAllUser() async{
    return await _repository.readData("user");
  }
  UpdateUser(user p) async{
    return await _repository.updateData("user", p.userMap());
  }
}