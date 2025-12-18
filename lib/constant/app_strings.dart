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
  // Dashboard
  final String scmTitle = 'SCM';
  final String tabSummary = 'Summary';
  final String tabSld = 'SLD';
  final String tabData = 'Data';
  final String electricitySection = 'Electricity';
  final String toggleSource = 'Source';
  final String toggleLoad = 'Load';
  final String analysisPro = 'Analysis Pro';
  final String gGenerator = 'G. Generator';
  final String plantSummary = 'Plant Summary';
  final String naturalGas = 'Natural Gas';
  final String dGenerator = 'D. Generator';
  final String waterProcess = 'Water Process';
  final String totalPower = 'Total Power';
  final String noDataMessage = 'No data is here,\nplease wait.';
  // List Item Details
  final String dataView = 'Data View';
  final String revenueView = 'Revenue View';
  final String todayData = 'Today Data';
  final String customDateData = 'Custom Date Data';
  final String fromDate = 'From Date';
  final String toDate = 'To Date';
  final String energyChart = 'Energy Chart';
  final String dataAndCostInfo = 'Data & Cost Info';
  final String dataLabel = 'Data';
  final String costLabel = 'Cost';
  final String tkSymbol = '৳';
  final String kwhSqft = 'kWh/Sqft';
  final String kw = 'kw';
}
