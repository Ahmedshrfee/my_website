import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interaction_controller.dart';
import '../utils/app_colors.dart';

class GlowingNavItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isMobile;

  const GlowingNavItem({
    Key? key,
    required this.text,
    required this.onTap,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InteractionController(), tag: 'nav_$text');

    return MouseRegion(
      onEnter: (_) => controller.onEnter(true),
      onExit: (_) => controller.onEnter(false),
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        // 1. عند وضع الإصبع: شغل الضوء
        onTapDown: (_) => controller.onPressed(true),

        // 2. عند رفع الإصبع: لا تطفئه فوراً! اتركه مضيئاً ليعمل التأخير في الأسفل
        onTapUp: (_) {
          // تركناها فارغة عمداً لكي لا ينطفئ الضوء قبل انتهاء التأخير
        },

        // 3. عند إلغاء اللمس (سحب الإصبع بعيداً): طف الضوء
        onTapCancel: () => controller.onPressed(false),

        // 4. عند تأكيد الضغطة (التعديل الجوهري هنا)
        onTap: () async {
          // تأكيد تشغيل الضوء (لضمان أنه مضيء)
          controller.onPressed(true);

          // انتظر 300 ميلي ثانية (وقت كافٍ لرؤية الانيمشن)
          await Future.delayed(Duration(milliseconds: 300));

          // الآن نفذ الانتقال أو إغلاق القائمة
          onTap();

          // أخيراً طف الضوء (في حال بقينا في نفس الصفحة)
          controller.onPressed(false);
        },

        child: Obx(() {
          final active = controller.isActive;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: active ? Colors.white : AppColors.textWhite
                      .withOpacity(0.9),
                  fontSize: isMobile ? 18 : 16,
                  fontWeight: active ? FontWeight.bold : FontWeight.w500,
                  shadows: active ? [
                    BoxShadow(color: AppColors.primary.withOpacity(0.8),
                        blurRadius: 10),
                  ] : [],
                ),
                child: Text(text),
              ),

              SizedBox(height: 4),

              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                height: 3,
                width: active ? 40 : 6,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(active ? 0.8 : 0.4),
                      blurRadius: active ? 15 : 5,
                      spreadRadius: active ? 2 : 0,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}