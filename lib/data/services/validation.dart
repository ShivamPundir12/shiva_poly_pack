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
  String date = "$day-$month-$year";

  return date;
}

String formatWithMonDate(String inputDate) {
  // Parse the input date string into a DateTime object
  DateTime parsedDate = DateTime.parse(inputDate);

  // Map of month numbers to short names
  const monthNames = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  // Extract day, month name, and last two digits of the year
  String day = parsedDate.day.toString().padLeft(2, '0');
  String month = monthNames[parsedDate.month]!;
  String year = parsedDate.year.toString().substring(2);

  // Combine into the desired format
  String formattedDate = "$day-$month-$year";

  return formattedDate;
}
