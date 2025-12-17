class AppStrings {
  AppStrings._privateConstructor();
  static final AppStrings _instance = AppStrings._privateConstructor();
  static AppStrings get instance => _instance;

  // App info
  final String appName = 'SCUBE';
  final String appSubtitle = 'Control & Monitoring System';

  // Login screen
  final String login = 'Login';
  final String username = 'Username';
  final String password = 'Password';
  final String forgetPassword = 'Forget password?';
  final String dontHaveAccount = "Don't have any account?";
  final String registerNow = 'Register Now';

  // Validation messages
  final String usernameRequired = 'Username is required';
  final String passwordRequired = 'Password is required';
  final String invalidCredentials = 'Invalid username or password';
}
