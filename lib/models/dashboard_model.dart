class DashboardItemModel {
  final int? id;
  final String? title;
  final String? status;
  final String? statusColor;
  final String? icon;
  final String? data1Label;
  final String? data1Value;
  final String? data2Label;
  final String? data2Value;

  DashboardItemModel({
    this.id,
    this.title,
    this.status,
    this.statusColor,
    this.icon,
    this.data1Label,
    this.data1Value,
    this.data2Label,
    this.data2Value,
  });

  factory DashboardItemModel.fromJson(Map<String, dynamic> json) {
    return DashboardItemModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      statusColor: json['statusColor'],
      icon: json['icon'],
      data1Label: json['data1Label'],
      data1Value: json['data1Value'],
      data2Label: json['data2Label'],
      data2Value: json['data2Value'],
    );
  }
}

class DashboardDataModel {
  final double? totalPower;
  final String? unit;
  final List<DashboardItemModel>? dataList;

  DashboardDataModel({this.totalPower, this.unit, this.dataList});

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['dataList'] as List?;
    List<DashboardItemModel>? dataList = list
        ?.map((i) => DashboardItemModel.fromJson(i))
        .toList();

    return DashboardDataModel(
      totalPower: json['totalPower']?.toDouble(),
      unit: json['unit'],
      dataList: dataList,
    );
  }
}
