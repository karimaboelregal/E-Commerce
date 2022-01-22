
class userD {

  String uid, name, Address, Type, about, phone, email, key, photo;



  userD({
    required this.uid,
    required this.Address,
    required this.Type,
    required this.about,
    required this.phone,
    required this.email,
    required this.name,
    required this.key,
    required this.photo,

  });


  factory userD.fromJson(Map<dynamic, dynamic> json, String key) {

    return userD(

      uid: json['uid'],
      Address: json['Address'],
      Type: json['Type'],
      about: json['about'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
      key: key,
      photo: json['photo'],
    );
  }

}


