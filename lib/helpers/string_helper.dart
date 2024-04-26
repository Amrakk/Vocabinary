String toLowerCaseNonAccentVietnamese(String str) {
  str = str.toLowerCase();
  str = str.replaceAll(RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'), "a");
  str = str.replaceAll(RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'), "e");
  str = str.replaceAll(RegExp(r'ì|í|ị|ỉ|ĩ'), "i");
  str = str.replaceAll(RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'), "o");
  str = str.replaceAll(RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'), "u");
  str = str.replaceAll(RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'), "y");
  str = str.replaceAll(RegExp(r'đ'), "d");
  str = str.replaceAll(RegExp(r'\u0300|\u0301|\u0303|\u0309|\u0323'), "");
  str = str.replaceAll(RegExp(r'\u02C6|\u0306|\u031B'), "");
  return str;
}
