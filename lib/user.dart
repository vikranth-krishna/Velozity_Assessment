class user{
int? id;
String? name;
String? email;


userMap(){
  var mapping = Map<String, dynamic>();
  mapping['id']=id??null;
  mapping['name']=name;
  mapping['email']=email;
  return mapping;
}
}