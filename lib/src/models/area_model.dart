class SyAreaModel {
  String? province;
  String? city;
  String? county;

  SyAreaModel({this.province, this.city, this.county});

  Map<String, dynamic> toJson() => {
        "province": province,
        "city": city,
        "county": county,
      };
}
