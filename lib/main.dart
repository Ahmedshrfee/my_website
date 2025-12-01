import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// هذه الاستدعاءات ضرورية جداً لدعم العربية
import 'package:flutter_localizations/flutter_localizations.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'محفظتي الشخصية',

      // --- إعدادات اللغة العربية والاتجاه ---
      locale: Locale('ar', 'AE'),
      // تحديد اللغة الافتراضية عربية
      fallbackLocale: Locale('ar', 'AE'),
      // لغة احتياطية

      // تفويضات الترجمة (هذه المسؤولة عن قلب الاتجاه وتعريب الودجت الجاهزة)
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: [
        const Locale('ar', 'AE'), // العربية
        const Locale('en', 'US'), // الإنجليزية (اذا احتجتها مستقبلاً)
      ],
      // ------------------------------------

      theme: ThemeData(
        // استخدمنا خط "كايرو" لأنه ممتاز مع العربية
        textTheme: GoogleFonts.cairoTextTheme(),
        primarySwatch: Colors.teal,

        // تعديل اتجاه الأيقونات التلقائي (اختياري ولكنه مفيد)
        iconTheme: IconThemeData(opacity: 1),
      ),
      home: HomeView(),
    );
  }
}