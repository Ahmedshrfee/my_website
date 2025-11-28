import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // استدعاء مكتبة الأيقونات
import 'package:url_launcher/url_launcher.dart'; // لفتح الروابط
import '../utils/app_colors.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialIcon({
    Key? key,
    required this.icon,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        onPressed: () async {
          final Uri uri = Uri.parse(url);
          // استخدام mode: LaunchMode.externalApplication مهم لفتح تطبيقات مثل واتساب
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            // يمكنك إضافة سناك بار هنا في حال الفشل
            print("Could not launch $url");
          }
        },
        // الأيقونة
        icon: FaIcon(icon, size: 28, color: AppColors.textWhite),
        // لون خلفية خفيف عند الهوفر
        hoverColor: AppColors.primary.withOpacity(0.2),
        // تكبير وتصغير تأثير الضغطة
        splashRadius: 25,
        padding: EdgeInsets.all(12), // مساحة للضغط
      ),
    );
  }
}