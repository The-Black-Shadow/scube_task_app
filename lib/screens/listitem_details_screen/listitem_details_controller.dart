import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/constant/app_strings.dart';
import 'package:scube_task_app/repositories/list_item_details_repository.dart';

class ListItemDetailsController extends GetxController {
  final ListItemDetailsRepository _repository = ListItemDetailsRepository();

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
      final result = await _repository.fetchDetailsData();

      if (result.detailsList != null) {
        dataItems.value = result.detailsList!.map((e) {
          return {
            'title': e.title ?? 'Unknown',
            'data': e.data ?? '0',
            'cost': '${e.cost} ${AppStrings.instance.tkSymbol}',
            'color': e.color ?? '',
          };
        }).toList();

        // For revenue view, we might want to use the same or different data.
        // Assuming same structure for now or keeping existing logic if revenue was different.
        // But the previous code used the same dataList for both.
        revenueItems.value = result.detailsList!.map((e) {
          return {
            'title': e.title ?? 'Unknown',
            'data': e.data ?? '0',
            'cost': '${e.cost} ${AppStrings.instance.tkSymbol}',
            'color': e.color ?? '',
          };
        }).toList();
      } else {
        dataItems.clear();
        revenueItems.clear();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching details: $e');
      }
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
