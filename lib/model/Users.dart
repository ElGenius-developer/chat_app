class Users {
  String email;
  String firstName;
  String imageLink;
  String lastName;
  String uid;

  Users(
      {this.email,
        this.firstName,
        this.imageLink,
        this.lastName,
        this.uid,
        });

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    imageLink = json['imageLink'];
    lastName = json['lastName'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['imageLink'] = this.imageLink;
    data['lastName'] = this.lastName;
    data['uid'] = this.uid;
    return data;
  }
}