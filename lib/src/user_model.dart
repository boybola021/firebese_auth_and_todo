
class UserSRC{
  String id;
  String name;
  String email;
  String password;
  //List<OrderModelProduct> history;

  UserSRC({
   required this.id,
   required this.name,
   required this.email,
   required this.password,
    ///required this.history,
});

  factory UserSRC.fromJson(Map<String,Object?> json){
    return UserSRC(
        id: json["id"] as String,
        name: json["name"] as String,
        email: json["email"] as String,
        password: json["password"] as String,
       // history: (json["history"] as List).map((e) => OrderModelProduct.fromJson(e as Map<String,Object?>)).toList(),
    );
  }

  Map<String,Object?> toJson() => {
    "id" : id,
    "name" : name,
    "email" : email,
    "password" : password,
    //"history": history,
  };

   @override
  bool operator == (Object other){
     return (other is UserSRC) && other.id == id && other.name == name &&
         other.email == email && other.password == password ;//&& other.history == history;
   }
  @override
  int get hashCode => Object.hash(id,name,email,password);
}