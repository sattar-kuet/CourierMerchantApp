class Validation {
  static dynamic validdateMobile(value) {
    if (value.isEmpty) {
      return 'Please enter your mobile number';
    }
    String pattern = r"^(01|8801|\+8801)[13456789](\d){8}$";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value) ? null : 'Please Enter a valid number';
  }

  static dynamic required(value) {
    if (value.isEmpty) {
      return 'This field is required.';
    }
  }
}
