import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ModernBackground extends StatelessWidget {
  final Widget child;

  const ModernBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الطبقة 1: لون الخلفية الأساسي
        Container(color: AppColors.background),

        // الطبقة 2: تدرج لوني (Gradient) في الزاوية العلوية
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  Colors.transparent
                ],
              ),
            ),
          ),
        ),

        // الطبقة 3: تدرج لوني آخر في الأسفل
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.purple.withOpacity(0.15), Colors.transparent],
              ),
            ),
          ),
        ),

        // الطبقة 4: شبكة منقطة خفيفة (Tech Pattern)
        Opacity(
          opacity: 0.05,
          child: CustomPaint(
            size: Size.infinite,
            painter: GridPainter(),
          ),
        ),

        // المحتوى الرئيسي
        child,
      ],
    );
  }
}

// راسم الشبكة
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    // رسم خطوط أفقية وعمودية متباعدة
    double step = 40;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}