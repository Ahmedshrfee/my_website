import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/skill_model.dart';
import '../utils/app_colors.dart';

class SkillCard extends StatefulWidget {
  final SkillModel skill;

  const SkillCard({Key? key, required this.skill}) : super(key: key);

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            // الإطار يضيء عند الهوفر
            color: isHovered ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            // الظل يصبح ملوناً عند الهوفر
            BoxShadow(
              color: isHovered ? AppColors.primary.withOpacity(0.3) : Colors
                  .black.withOpacity(0.2),
              blurRadius: isHovered ? 15 : 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الأيقونة (تكبر قليلاً وتتلون عند الهوفر)
            AnimatedScale(
              scale: isHovered ? 1.1 : 1.0,
              duration: Duration(milliseconds: 300),
              child: FaIcon(
                widget.skill.icon,
                size: 40,
                color: isHovered ? AppColors.primary : Colors.white70,
              ),
            ),
            SizedBox(height: 15),
            // النص
            Text(
              widget.skill.name,
              style: TextStyle(
                color: isHovered ? Colors.white : Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}