class SyAddressModel {
  String name;
  String phone;
  String province;
  String city;
  String county;
  String detailAddress;
  String areaCode;
  bool isDefault;

  SyAddressModel(
      {this.name = '',
      this.phone = '',
      this.province = '',
      this.city = '',
      this.county = '',
      this.isDefault = false,
      this.areaCode = '',
      this.detailAddress = ''});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'province': province,
        'city': city,
        'county': county,
        'detail_address': detailAddress,
        'is_default': isDefault,
        'area_code': areaCode,
      };

  String get area => '$province/$city/$county';

  String get completeAddress => area + ' ' + detailAddress;
}
