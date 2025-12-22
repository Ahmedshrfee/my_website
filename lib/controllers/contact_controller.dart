import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // حالة التحميل
  var isLoading = false.obs;

  Future<void> sendMessage() async {
    // 1. التحقق من المدخلات
    if (emailController.text.isEmpty || messageController.text.isEmpty) {
      Get.snackbar("خطأ", "الرجاء ملء جميع الحقول",
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      // 2. رابط الدالة (استبدل الرابط برابط موقعك الحقيقي بعد الرفع)
      // أثناء التطوير المحلي قد تحتاج لاستخدام رابط محلي إذا كنت تشغل netlify dev
      // لكن عند الرفع سيصبح الرابط: https://your-site.netlify.app/.netlify/functions/submit_message

      // ملاحظة: لجعل الرابط ديناميكياً، يفضل وضع الدومين الأساسي في ملف الثوابت
      var url = Uri.parse('/.netlify/functions/submit_message');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "message": messageController.text,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("نجاح", "تم إرسال رسالتك بنجاح!",
            backgroundColor: Colors.green.withOpacity(0.5),
            colorText: Colors.white);

        // تفريغ الحقول
        emailController.clear();
        messageController.clear();
      } else {
        throw "Server Error";
      }
    } catch (e) {
      Get.snackbar("فشل", "حدث خطأ أثناء الإرسال، حاول لاحقاً",
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white);
      print("Error sending message: $e");
    } finally {
      isLoading.value = false;
    }
  }
}