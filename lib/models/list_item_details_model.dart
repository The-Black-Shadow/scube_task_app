class ListItemDetailsItemModel {
  final String? title;
  final String? data;
  final String? cost;
  final String? color;

  ListItemDetailsItemModel({this.title, this.data, this.cost, this.color});

  factory ListItemDetailsItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemDetailsItemModel(
      title: json['title'],
      data: json['data'],
      cost: json['cost'],
      color: json['color'],
    );
  }
}

class ListItemDetailsDataModel {
  final double? totalPower;
  final String? unit;
  final List<ListItemDetailsItemModel>? detailsList;

  ListItemDetailsDataModel({this.totalPower, this.unit, this.detailsList});

  factory ListItemDetailsDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['detailsList'] as List?;
    List<ListItemDetailsItemModel>? detailsList = list
        ?.map((i) => ListItemDetailsItemModel.fromJson(i))
        .toList();

    return ListItemDetailsDataModel(
      totalPower: json['totalPower']?.toDouble(),
      unit: json['unit'],
      detailsList: detailsList,
    );
  }
}
