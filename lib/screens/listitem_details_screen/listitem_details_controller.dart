import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/repositories/dashboard_repository.dart';

class ListItemDetailsController extends GetxController {
  final DashboardRepository _repository = DashboardRepository();

  final RxInt viewType = 0.obs;

  final RxInt dateType = 0.obs;

  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;

  final RxBool isLoading = true.obs;

  final RxList<Map<String, String>> dataItems = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> revenueItems = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      await _repository.fetchDashboardData();

      dataItems.value = [
        {
          'title': 'Data A',
          'data': '2798.50 (29.53%)',
          'cost': '35689 ${AppStrings.instance.tkSymbol}',
        },
        {
          'title': 'Data B',
          'data': '72598.50 (35.39%)',
          'cost': '5259689 ${AppStrings.instance.tkSymbol}',
        },
        {
          'title': 'Data C',
          'data': '6598.36 (83.90%)',
          'cost': '5698756 ${AppStrings.instance.tkSymbol}',
        },
        {
          'title': 'Data D',
          'data': '6598.26 (36.59%)',
          'cost': '356987 ${AppStrings.instance.tkSymbol}',
        },
      ];

      revenueItems.value = [
        {
          'title': 'Data 1',
          'data': '2798.50 (29.53%)',
          'cost': '35689 ${AppStrings.instance.tkSymbol}',
        },
        {
          'title': 'Data 2',
          'data': '2798.50 (29.53%)',
          'cost': '35689 ${AppStrings.instance.tkSymbol}',
        },
        {
          'title': 'Data 3',
          'data': '2798.50 (29.53%)',
          'cost': '35689 ${AppStrings.instance.tkSymbol}',
        },
        {
          'title': 'Data 4',
          'data': '2798.50 (29.53%)',
          'cost': '35689 ${AppStrings.instance.tkSymbol}',
        },
      ];
    } catch (e) {
      print('Error fetching details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setViewType(int type) {
    viewType.value = type;
  }

  void setDateType(int type) {
    dateType.value = type;
  }
}
