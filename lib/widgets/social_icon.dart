import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  // إضافة اسم للمنصة ليقرأه جوجل (مثلاً: "حسابي على واتساب")
  final String label;

  const SocialIcon({
    Key? key,
    required this.icon,
    required this.url,
    this.label = "رابط تواصل اجتماعي", // قيمة افتراضية
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
            print("Could not launch $url");
          }
        },
        icon: FaIcon(icon, size: 28, color: AppColors.textWhite),
        hoverColor: AppColors.primary.withOpacity(0.2),
        splashRadius: 25,
        padding: EdgeInsets.all(12),

        // === الحل لمشاكل SEO ===
        // التلميح (Tooltip) يقرأه قارئ الشاشة ويعتبره جوجل "Accessible Name"
        tooltip: label,
      ),
    );
  }
}