class SyAreaModel {
  String province;
  String city;
  String county;
  String areaCode;

  SyAreaModel({this.province, this.city, this.county, this.areaCode = ''});

  Map<String, dynamic> toJson() => {
        "province": province,
        "city": city,
        "county": county,
        "area_code": areaCode
      };
}
