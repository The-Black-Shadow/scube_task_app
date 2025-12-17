import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scube_task_app/models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardDataModel> fetchDashboardData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final String response = await rootBundle.loadString(
        'assets/data/dashboard_data.json',
      );
      final data = await json.decode(response);
      return DashboardDataModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load dashboard data');
    }
  }
}
