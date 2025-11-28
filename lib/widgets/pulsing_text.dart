import 'package:flutter/material.dart';

class PulsingText extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;

  const PulsingText({
    Key? key,
    required this.text,
    required this.color,
    this.fontSize = 24,
  }) : super(key: key);

  @override
  _PulsingTextState createState() => _PulsingTextState();
}

class _PulsingTextState extends State<PulsingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. إعداد الكنترولر: مدة النبضة ثانيتان
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 2. إعداد الأنيميشن: التوهج يبدأ من 5 وينتهي عند 25
    _animation = Tween<double>(begin: 5, end: 25).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 3. تشغيل الأنيميشن بشكل متكرر (للأمام ثم للخلف)
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder يعيد بناء نفسه مع كل تغيير في قيمة الأنيميشن
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: TextStyle(
            color: widget.color,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            shadows: [
              // الظل الأول: لون قوي وقيمة توهج متغيرة
              BoxShadow(
                color: widget.color.withOpacity(0.8),
                blurRadius: _animation.value, // القيمة المتغيرة
                spreadRadius: 2,
              ),
              // الظل الثاني: هالة خفيفة لزيادة التأثير
              BoxShadow(
                color: widget.color.withOpacity(0.4),
                blurRadius: _animation.value * 1.5, // توهج أوسع
                spreadRadius: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}