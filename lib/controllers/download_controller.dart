import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html; // مكتبة الويب
import '../data/personal_info.dart';

class downloadController extends GetxController {

  // دالة تحميل الـ CV
  void downloadCV() {
    _downloadFile(
        PersonalInfo.cvDownloadUrl,
        filename: "Ahmed_CV.png"
    );
  }

  // دالة تحميل الشهادة (عامة)
  void downloadCertificate(String url, String title) {
    _downloadFile(url, filename: "$title.png");
  }

  // المنطق الداخلي للتحميل (Private)
  void _downloadFile(String url, {String filename = "file.png"}) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final blob = html.Blob([response.bodyBytes]);
        final urlBlob = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: urlBlob)
          ..setAttribute("download", filename)
          ..click();
        html.Url.revokeObjectUrl(urlBlob);
      } else {
        Get.snackbar("تنبيه", "فشل الوصول للملف");
      }
    } catch (e) {
      // فتح في نافذة جديدة كحل بديل
      html.window.open(url, "_blank");
    }
  }
}