import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html; // مكتبة الويب لتحميل الملفات
import 'package:url_launcher/url_launcher.dart'; // لفتح الروابط الخارجية
import '../data/personal_info.dart';

class downloadController extends GetxController {

  // ================== دالة فتح الروابط الخارجية (للمشاريع) ==================
  // تستخدم هذه الدالة لفتح رابط GitHub عند الضغط على زر المشروع
  Future<void> launchWebUrl(String url) async {
    final Uri uri = Uri.parse(url);
    // mode: LaunchMode.externalApplication يضمن فتح الرابط في لسان جديد
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("تنبيه", "لا يمكن فتح الرابط: $url");
    }
  }

  // ================== دوال تحميل الملفات (CV & Certificates) ==================

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

  // المنطق الداخلي للتحميل (Private Function)
  // تقوم بجلب بيانات الملف وتحويلها لـ Blob لإجبار المتصفح على التحميل
  void _downloadFile(String url, {String filename = "file.png"}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // تحويل البيانات إلى كائن Blob
        final blob = html.Blob([response.bodyBytes]);
        // إنشاء رابط مؤقت في الذاكرة
        final urlBlob = html.Url.createObjectUrlFromBlob(blob);
        // إنشاء عنصر رابط مخفي والضغط عليه برمجياً
        final anchor = html.AnchorElement(href: urlBlob)
          ..setAttribute("download", filename)
          ..click();
        // تنظيف الذاكرة
        html.Url.revokeObjectUrl(urlBlob);
      } else {
        Get.snackbar("تنبيه", "فشل الوصول للملف، تأكد من صحة الرابط");
      }
    } catch (e) {
      // الحل البديل في حال فشل التحميل المباشر: فتح الصورة في نافذة جديدة
      html.window.open(url, "_blank");
    }
  }
}