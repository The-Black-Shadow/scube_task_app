import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/routes/app_routes.dart';

class LoginScreenController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.instance.usernameRequired;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.instance.passwordRequired;
    }
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      final username = usernameController.text.trim();
      final password = passwordController.text.trim();

      if (username.isNotEmpty && password.isNotEmpty) {
        
        Get.offAllNamed(AppRoutes.instance.dashboardScreen);
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          AppStrings.instance.invalidCredentials,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToForgotPassword() {
    Get.snackbar(
      'Info',
      'Forgot password functionality coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToRegister() {
    Get.snackbar(
      'Info',
      'Register functionality coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
