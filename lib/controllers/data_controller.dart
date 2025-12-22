import 'package:get/get.dart';

// استدعاء المودلز
import '../models/project_model.dart';
import '../models/certificate_model.dart';
import '../models/skill_model.dart';

// استدعاء ملفات البيانات
import '../data/personal_info.dart';
import '../data/projects_data.dart';
import '../data/skills_data.dart';
import '../data/certificates_data.dart';

class dataController extends GetxController {
  // ================== المعلومات الشخصية ==================
  final String aboutMe = PersonalInfo.aboutMe;
  final String whatsappUrl = PersonalInfo.whatsappUrl;
  final String linkedinUrl = PersonalInfo.linkedinUrl;
  final String githubUrl = PersonalInfo.githubUrl;

  // ================== القوائم ==================
  // نستخدم getter لضمان جلب البيانات المحدثة أو يمكن جعلها متغيرات عادية
  List<ProjectModel> get projects => projectList;

  List<SkillModel> get skills => skillList;

  List<CertificateModel> get certificates => certificateList;
}