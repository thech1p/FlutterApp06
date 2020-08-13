
class UserAccount
{
  String id; 
  String name;
  int age;
  UserAccount(this.id, this.name, this.age);
  factory UserAccount.fromJson(Map<String,dynamic> data)
  {
    return new UserAccount(data["id"], data["name"], data["age"]);
  }
}