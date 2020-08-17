class UserAccount
{
  String id;
  String email;
  String reflink;
  int score;

  UserAccount(this.id, this.email, this.reflink, this.score);
  factory UserAccount.fromJson(Map<String,dynamic> data)
  {
    return new UserAccount(data["id"], data["email"], data["reflink"], data["score"]);
  }

  Map<String, dynamic> toJson() => 
  {
    "id":id,
    "email":email,
    "reflink":reflink,
    "score":score
  };
}