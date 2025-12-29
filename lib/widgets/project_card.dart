import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/project_model.dart';
import '../controllers/interaction_controller.dart';
import '../controllers/download_controller.dart'; // استدعاء كنترولر التحميل/الروابط
import '../utils/app_colors.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        InteractionController(), tag: 'card_${project.title}');
    // استدعاء الكنترولر الذي يحتوي على دالة فتح الروابط
    final urlController = Get.find<downloadController>();

    return GestureDetector(
      onTap: () => controller.toggle(),
      child: MouseRegion(
        onEnter: (_) => controller.onEnter(true),
        onExit: (_) => controller.onEnter(false),

        child: Obx(() {
          final active = controller.isActive;

          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..translate(0, active ? -10.0 : 0.0),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                active
                    ? BoxShadow(
                  color: AppColors.primary.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 10),
                )
                    : BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // الطبقة 1: المحتوى
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.code, color: AppColors.primary, size: 40),
                        SizedBox(height: 20),
                        Text(project.title, style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(project.description, style: TextStyle(
                            color: AppColors.textWhite, height: 1.5),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                        Spacer(),
                        Text(project.techStack, style: TextStyle(
                            color: AppColors.textGrey, fontSize: 12)),
                      ],
                    ),
                  ),

                  // الطبقة 2: التغبيش
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: active ? 1.0 : 0.0,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(color: Colors.black.withOpacity(0.2)),
                      ),
                    ),
                  ),

                  // الطبقة 3: الزر
                  Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: active ? 1.0 : 0.0,
                      child: AnimatedScale(
                        scale: active ? 1.0 : 0.8,
                        duration: Duration(milliseconds: 300),
                        child: ElevatedButton(
                          // ================== ربط الزر هنا ==================
                          onPressed: active ? () {
                            urlController.launchWebUrl(project.gitHubUrl);
                          } : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          child: Text("عرض على GitHub",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}