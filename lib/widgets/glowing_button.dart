import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interaction_controller.dart';
import '../utils/app_colors.dart';

class GlowingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GlowingButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ننشئ نسخة فريدة من الكنترولر لهذا الزر باستخدام النص كـ "Tag"
    final controller = Get.put(InteractionController(), tag: 'btn_$text');

    return MouseRegion(
      onEnter: (_) => controller.onEnter(true),
      onExit: (_) => controller.onEnter(false),
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTapDown: (_) => controller.onPressed(true),
        onTapUp: (_) {},
        // نلغي الإطفاء الفوري هنا
        onTapCancel: () => controller.onPressed(false),

        onTap: () async {
          controller.onPressed(true);
          // تأخير عشان نشوف "اللمعة"
          await Future.delayed(Duration(milliseconds: 250));
          onPressed(); // تنفيذ الأمر الأصلي
          controller.onPressed(false);
        },

        // نستخدم Obx هنا لمراقبة التغيرات
        child: Obx(() {
          final active = controller.isActive; // للتسهيل

          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: active ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primary, width: 2),
              boxShadow: active
                  ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ]
                  : [],
            ),
            child: Text(
              text,
              style: TextStyle(
                color: active ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        }),
      ),
    );
  }
}