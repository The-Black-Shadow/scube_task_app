import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_assert_image.dart';
import 'package:scube_task_app/constant/app_colors.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/constant/app_text_styles.dart';
import 'package:scube_task_app/screens/login_screen/login_screen_controller.dart';
import 'package:scube_task_app/utils/app_size.dart';
import 'package:scube_task_app/widgets/app_text_field.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.primaryBlue,
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildHeader()),

          Expanded(
            child: ClipPath(
              clipper: _CurvedTopClipper(),
              child: Container(
                width: double.infinity,
                color: AppColors.instance.white,
                child: SingleChildScrollView(child: _buildLoginForm()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.height(value: 20),
        bottom: AppSize.height(value: 60),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssertImage.instance.logo,
            width: AppSize.width(value: 96),
            height: AppSize.width(value: 96),
            fit: BoxFit.contain,
          ),
          SizedBox(height: AppSize.height(value: 20)),

          Text(
            AppStrings.instance.appName,
            style: AppTextStyles.instance.appNameStyle,
          ),
          SizedBox(height: AppSize.height(value: 8)),

          Text(
            AppStrings.instance.appSubtitle,
            style: AppTextStyles.instance.appSubtitleStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 30)),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppSize.height(value: 30)),

            Center(
              child: Text(
                AppStrings.instance.login,
                style: AppTextStyles.instance.loginHeadingStyle,
              ),
            ),
            SizedBox(height: AppSize.height(value: 30)),

            AppTextField(
              hintText: AppStrings.instance.username,
              controller: controller.usernameController,
              keyboardType: TextInputType.text,
              validator: controller.validateUsername,
            ),
            SizedBox(height: AppSize.height(value: 16)),

            Obx(
              () => AppTextField(
                hintText: AppStrings.instance.password,
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                validator: controller.validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.instance.textGrey,
                    size: AppSize.width(value: 22),
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: AppSize.height(value: 12)),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: controller.navigateToForgotPassword,
                child: Text(
                  AppStrings.instance.forgetPassword,
                  style: AppTextStyles.instance.linkStyle,
                ),
              ),
            ),
            SizedBox(height: AppSize.height(value: 24)),

            Obx(
              () => SizedBox(
                height: AppSize.height(value: 50),
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.instance.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSize.width(value: 10),
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: AppSize.width(value: 20),
                          width: AppSize.width(value: 20),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.instance.white,
                            ),
                          ),
                        )
                      : Text(
                          AppStrings.instance.login,
                          style: AppTextStyles.instance.buttonTextStyle,
                        ),
                ),
              ),
            ),
            SizedBox(height: AppSize.height(value: 10)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.instance.dontHaveAccount,
                  style: AppTextStyles.instance.bodyTextStyle,
                ),
                SizedBox(width: AppSize.width(value: 4)),
                GestureDetector(
                  onTap: controller.navigateToRegister,
                  child: Text(
                    AppStrings.instance.registerNow,
                    style: AppTextStyles.instance.linkStyleBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.height(value: 30)),
          ],
        ),
      ),
    );
  }
}

class _CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double curveRadius = 30;
    final path = Path();

    path.moveTo(0, curveRadius);

    path.quadraticBezierTo(0, 0, curveRadius, 0);

    path.lineTo(size.width - curveRadius, 0);

    path.quadraticBezierTo(size.width, 0, size.width, curveRadius);

    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
