import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  /// Opens WhatsApp chat with the given details
  static void openWhatsAppChat({
    required String phoneNumber,
    required String userName,
    String? userContactNumber,
  }) async {
    final encodedText = Uri.encodeComponent(
      "Hello ShivaPolyPack,\n\n"
      "This is $userName contacting you via the mobile app.\n\n"
      "Please let me know how to proceed. Thank you!\n\n"
      "Best regards,\n$userName\n${userContactNumber ?? ''}",
    );

    final url =
        "https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedText";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar(
        "Error",
        "Could not open WhatsApp. Please ensure the app is installed.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
