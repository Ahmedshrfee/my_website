import 'package:get/get.dart';

class InteractionController extends GetxController {
  var isHovered = false.obs;
  var isPressed = false.obs;

  // الخاصية المحسوبة التي تجمع الحالتين
  bool get isActive => isHovered.value || isPressed.value;

  void onEnter(bool value) => isHovered.value = value;

  void onPressed(bool value) => isPressed.value = value;

  void toggle() => isPressed.value = !isPressed.value;
}