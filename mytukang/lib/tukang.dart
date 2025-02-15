class Tukang {
  String? tukangId;
  String? tukangName;
  String? tukangField;
  String? tukangDesc;
  String? tukangPhone;
  String? tukangEmail;
  String? tukangLocation;
  String? tukangDatereg;
  String? tukangOtp;
  String? tukangPass;

  Tukang(
      {this.tukangId,
      this.tukangName,
      this.tukangField,
      this.tukangDesc,
      this.tukangPhone,
      this.tukangEmail,
      this.tukangLocation,
      this.tukangDatereg,
      this.tukangOtp,
      this.tukangPass});

  Tukang.fromJson(Map<String, dynamic> json) {
    tukangId = json['tukang_id'];
    tukangName = json['tukang_name'];
    tukangField = json['tukang_field'];
    tukangDesc = json['tukang_desc'];
    tukangPhone = json['tukang_phone'];
    tukangEmail = json['tukang_email'];
    tukangLocation = json['tukang_location'];
    tukangDatereg = json['tukang_datereg'];
    tukangOtp = json['tukang_otp'];
    tukangPass = json['tukang_pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tukang_id'] = tukangId;
    data['tukang_name'] = tukangName;
    data['tukang_field'] = tukangField;
    data['tukang_desc'] = tukangDesc;
    data['tukang_phone'] = tukangPhone;
    data['tukang_email'] = tukangEmail;
    data['tukang_location'] = tukangLocation;
    data['tukang_datereg'] = tukangDatereg;
    data['tukang_otp'] = tukangOtp;
    data['tukang_pass'] = tukangPass;
    return data;
  }
}
