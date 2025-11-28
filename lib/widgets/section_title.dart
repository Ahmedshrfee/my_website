import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // يأخذ أقل مساحة ممكنة
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. الدائرة المضيئة
        Container(
          width: 12, // حجم الدائرة
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.primary, // لون الدائرة الأساسي
            shape: BoxShape.circle,
            boxShadow: [
              // إضاءة قوية حول الدائرة
              BoxShadow(
                color: AppColors.primary.withOpacity(0.8),
                blurRadius: 10, // مدى انتشار الضوء
                spreadRadius: 2,
              ),
              // هالة إضافية خفيفة
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
        ),

        SizedBox(width: 15), // مسافة بين الدائرة والنص

        // 2. النص الأبيض المتوهج
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelper.isMobile(context) ? 24 : 30,
            fontWeight: FontWeight.bold,
            shadows: [
              // توهج أبيض خفيف وناعم للنص
              BoxShadow(
                color: Colors.white.withOpacity(0.6),
                blurRadius: 15,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}