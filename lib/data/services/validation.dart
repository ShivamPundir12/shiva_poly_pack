class ValidationService {
  static final RegExp _mobileNumberRegex = RegExp(r'^[6-9]\d{9}$');

  /// Validate 10-digit mobile number
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required!';
    } else if (!_mobileNumberRegex.hasMatch(value)) {
      return 'Invalid mobile number';
    }
    return null;
  }

  static String? normalvalidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the something!';
    }
    return null;
  }
}
