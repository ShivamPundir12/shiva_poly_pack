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

  static String? normalvalidation(String? value, String lable) {
    if (value == null || value.isEmpty) {
      return 'Please enter $lable!';
    }
    return null;
  }
}

String formatDate(String inputDate) {
  // Parse the input date string into a DateTime object
  DateTime parsedDate = DateTime.parse(inputDate);

  // Extract day, month, and year
  String day = parsedDate.day.toString().padLeft(2, '0');
  String month = parsedDate.month.toString().padLeft(2, '0');
  String year = parsedDate.year.toString().substring(2);

  //Time formatting
  // int hour = parsedDate.hour > 12 ? parsedDate.hour - 12 : parsedDate.hour;
  // hour = hour == 0 ? 12 : hour; // Convert 0 hour to 12
  // String minute = parsedDate.minute.toString().padLeft(2, '0');
  // String second = parsedDate.second.toString().padLeft(2, '0');
  // String period = parsedDate.hour >= 12 ? "PM" : "AM";
  // String convertedtime =
  //     "${hour.toString().padLeft(2, '0')}:$minute:$second $period";
  String date = "$day-$month-$year";

  return date;
}
