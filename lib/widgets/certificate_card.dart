import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/certificate_model.dart';
import '../utils/app_colors.dart';

class CertificateCard extends StatelessWidget {
  final CertificateModel certificate;

  const CertificateCard({Key? key, required this.certificate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20), // زوايا أكثر انحناءً
        boxShadow: [
          // ظل خلفي قوي وناعم (Back Shadow)
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // لون أغمق قليلاً
            blurRadius: 20, // انتشار واسع للظل
            spreadRadius: 2, // حجم الظل
            offset: Offset(0, 10), // اتجاه للأسفل
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // 1. الصورة (أخذت مساحة أقل قليلاً لترك مجال للنص)
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Colors.white10,
              child: Image.asset(
                certificate.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.workspace_premium, size: 60,
                        color: Colors.white24),
              ),
            ),
          ),

          // 2. المحتوى
          Expanded(
            flex: 6, // زدنا المساحة هنا لتكفي 5 أسطر وزر
            child: Padding(
              padding: const EdgeInsets.all(16.0), // هوامش داخلية مريحة
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Text(
                    certificate.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // كبرنا الخط قليلاً
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 10),

                  // الوصف (النص الجديد)
                  Expanded( // نستخدم Expanded ليأخذ المساحة المتاحة قبل الزر
                    child: Text(
                      certificate.description,
                      style: TextStyle(
                        color: Colors.grey[400], // لون رمادي فاتح
                        fontSize: 14,
                        fontWeight: FontWeight.w300, // خط نحيف جداً
                        height: 1.5, // تباعد بين الأسطر للقراءة
                      ),
                      maxLines: 5, // 5 أسطر كحد أقصى
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify, // محاذاة النص
                    ),
                  ),

                  SizedBox(height: 15),

                  // الزر
                  SizedBox(
                    width: double.infinity,
                    height: 45, // زر أكبر قليلاً
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse(certificate.downloadUrl);
                        if (!await launchUrl(url)) Get.snackbar(
                            "تنبيه", "الرابط غير صالح");
                      },
                      icon: Icon(Icons.download_rounded, size: 20,
                          color: Colors.white),
                      label: Text("تحميل الشهادة",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0, // إلغاء ظل الزر لأن الكرت له ظل
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}