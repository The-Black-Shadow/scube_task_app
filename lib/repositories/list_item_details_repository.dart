import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scube_task_app/models/list_item_details_model.dart';

class ListItemDetailsRepository {
  Future<ListItemDetailsDataModel> fetchDetailsData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final String response = await rootBundle.loadString(
        'assets/data/list_item_details_data.json',
      );
      final data = await json.decode(response);
      return ListItemDetailsDataModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load details data: $e');
    }
  }
}
