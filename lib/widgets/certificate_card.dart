import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/certificate_model.dart';
import '../utils/app_colors.dart';
import '../controllers/home_controller.dart'; // 1. استدعاء الكنترولر

class CertificateCard extends StatelessWidget {
  final CertificateModel certificate;

  const CertificateCard({Key? key, required this.certificate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // 1. الصورة
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
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Text(
                    certificate.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 10),

                  // الوصف
                  Expanded(
                    child: Text(
                      certificate.description,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  SizedBox(height: 15),

                  // الزر
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      // ================== التعديل هنا ==================
                      onPressed: () {
                        // 1. الوصول للكنترولر
                        final controller = Get.find<HomeController>();

                        // 2. استدعاء دالة التحميل المباشر
                        controller.downloadFile(
                            certificate.downloadUrl,
                            // نستخدم اسم الشهادة كاسم للملف عند التحميل
                            filename: "${certificate.title}.png"
                        );
                      },
                      // ===============================================
                      icon: Icon(Icons.download_rounded, size: 20,
                          color: Colors.white),
                      label: Text("تحميل الشهادة",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
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