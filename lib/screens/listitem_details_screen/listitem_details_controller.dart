import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/repositories/dashboard_repository.dart';

class ListItemDetailsController extends GetxController {
  final DashboardRepository _repository = DashboardRepository();

  final RxInt viewType = 0.obs;

  final RxInt dateType = 0.obs;

  final Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  final Rx<DateTime?> toDate = Rx<DateTime?>(null);

  final RxBool isLoading = true.obs;

  final RxList<Map<String, String>> dataItems = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> revenueItems = <Map<String, String>>[].obs;

  final RxBool isRevenueExpanded = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void toggleRevenueExpanded() {
    isRevenueExpanded.value = !isRevenueExpanded.value;
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      final result = await _repository.fetchDashboardData();

      if (result.dataList != null) {
        dataItems.value = result.dataList!.map((e) {
          return {
            'title': e.title ?? 'Unknown',
            'data': e.data1Value ?? '0',
            'cost': '${e.data2Value} ${AppStrings.instance.tkSymbol}',
            'color': e.statusColor ?? '',
          };
        }).toList();

        revenueItems.value = result.dataList!.map((e) {
          return {
            'title': e.title ?? 'Unknown',
            'data': e.data1Value ?? '0',
            'cost': '${e.data2Value} ${AppStrings.instance.tkSymbol}',
            'color': e.statusColor ?? '',
          };
        }).toList();
      } else {
        dataItems.clear();
        revenueItems.clear();
      }
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

  void setFromDate(DateTime date) {
    fromDate.value = date;
  }

  void setToDate(DateTime date) {
    toDate.value = date;
  }
}
