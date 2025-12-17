import 'package:get/get.dart';
import 'package:scube_task_app/models/dashboard_model.dart';
import 'package:scube_task_app/repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository _repository = DashboardRepository();

  
  final Rx<DashboardDataModel?> dashboardData = Rx<DashboardDataModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  
  final RxInt selectedTabIndex = 0.obs; 
  final RxBool isSourceSelected = true.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      error.value = '';

      final data = await _repository.fetchDashboardData();
      dashboardData.value = data;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void toggleSourceLoad(bool isSource) {
    isSourceSelected.value = isSource;
  }
}
