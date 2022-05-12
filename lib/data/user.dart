class User{
  int id = 0;
  String token = '';
  String name = '';
  String mobile = '';
  int companyProfileId = 0;

  User(this.id, this.token, this.name, this.mobile, this.companyProfileId);

  User.fromJson(Map<String, dynamic> sessionMap){
     id               = sessionMap['id']?? 0;
     token            = sessionMap['token']?? '';
     name             = sessionMap['name']?? '';
     mobile           = sessionMap['mobile']?? '';
     companyProfileId = sessionMap['companyProfileId']?? '';
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'token': token,
      'name': name,
      'mobile': mobile,
      'companyProfileId' : companyProfileId,
    };
  }

}