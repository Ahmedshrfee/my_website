import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart'; // مهم جداً لاستدعاء SemanticsBinding
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'views/home_view.dart';

void main() {
  // 1. تفعيل Semantics (الترجمة لـ HTML) إجبارياً
  // هذا يجعل جوجل يفهم أن هناك أزرار ونصوص وليس مجرد رسم
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'محفظتي الشخصية',
      // العنوان الذي يظهر في التبويب

      // إعدادات اللغة العربية
      locale: Locale('ar', 'AE'),
      fallbackLocale: Locale('ar', 'AE'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', 'AE'),
        const Locale('en', 'US'),
      ],

      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(),
        primarySwatch: Colors.teal,
        // تحسين التباين للأيقونات
        iconTheme: IconThemeData(opacity: 1, color: Colors.white),
      ),

      // إضافة Semantics للروت
      home: Semantics(
        label: "الصفحة الرئيسية لمحفظة أعمالي",
        child: HomeView(),
      ),
    );
  }
}