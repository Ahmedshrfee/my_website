class CertificateModel {
  final String title;
  final String description; // <--- الحقل الجديد
  final String imagePath;
  final String downloadUrl;

  CertificateModel({
    required this.title,
    required this.description, // <--- مطلوب
    required this.imagePath,
    required this.downloadUrl,
  });
}