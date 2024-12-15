class ProfileResponse {
  Response? response;

  ProfileResponse({this.response});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    if (json["response"] is Map) {
      response =
      json["response"] == null ? null : Response.fromJson(json["response"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data["response"] = response?.toJson();
    }
    return data;
  }
}

class Response {
  String? userId;
  String? fullName;
  String? emailId;
  String? mobileNumber;
  String? gender;
  String? profilePhoto;
  String? coinBalance;
  String? walletBalance;
  String? userStatus;
  String? registeredDateTime;
  String? socialMediaId;
  String? msg;
  bool? status;

  Response(
      {this.userId,
        this.fullName,
        this.emailId,
        this.mobileNumber,
        this.gender,
        this.profilePhoto,
        this.coinBalance,
        this.walletBalance,
        this.userStatus,
        this.registeredDateTime,
        this.socialMediaId,
        this.msg,
        this.status});

  Response.fromJson(Map<String, dynamic> json) {
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["full_name"] is String) {
      fullName = json["full_name"];
    }
    if (json["email_id"] is String) {
      emailId = json["email_id"];
    }
    if (json["mobile_number"] is String) {
      mobileNumber = json["mobile_number"];
    }
    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["profile_photo"] is String) {
      profilePhoto = json["profile_photo"];
    }
    if (json["coin_balance"] is String) {
      coinBalance = json["coin_balance"];
    }
    if (json["wallet_balance"] is String) {
      walletBalance = json["wallet_balance"];
    }
    if (json["user_status"] is String) {
      userStatus = json["user_status"];
    }
    if (json["registered_date_time"] is String) {
      registeredDateTime = json["registered_date_time"];
    }
    if (json["social_media_id"] is String) {
      socialMediaId = json["social_media_id"];
    }
    if (json["msg"] is String) {
      msg = json["msg"];
    }
    if (json["status"] is bool) {
      status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = userId;
    data["full_name"] = fullName;
    data["email_id"] = emailId;
    data["mobile_number"] = mobileNumber;
    data["gender"] = gender;
    data["profile_photo"] = profilePhoto;
    data["coin_balance"] = coinBalance;
    data["wallet_balance"] = walletBalance;
    data["user_status"] = userStatus;
    data["registered_date_time"] = registeredDateTime;
    data["social_media_id"] = socialMediaId;
    data["msg"] = msg;
    data["status"] = status;
    return data;
  }
}