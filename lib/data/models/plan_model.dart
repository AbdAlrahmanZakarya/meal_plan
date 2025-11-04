class PlanModel {
  final String id;
  final String companyId;
  final String planName;
  final String imageUrl;
  final String description;
  final String startingPrice;
  final String tag;

  const PlanModel({
    required this.id,
    required this.companyId,
    required this.imageUrl,
    required this.planName,
    required this.tag,
    required this.description,
    required this.startingPrice,
  });

//<editor-fold desc="Data Methods">

  @override
  String toString() {
    return 'PlanModel{ id: $id, companyId: $companyId, imageUrl: $imageUrl, planName: $planName, tag: $tag, description: $description, startingPrice: $startingPrice,}';
  }

  PlanModel copyWith({
    String? id,
    String? companyId,
    String? imageUrl,
    String? planName,
    String? tag,
    String? description,
    String? startingPrice,
  }) {
    return PlanModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      imageUrl: imageUrl ?? this.imageUrl,
      planName: planName ?? this.planName,
      tag: tag ?? this.tag,
      description: description ?? this.description,
      startingPrice: startingPrice ?? this.startingPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'imageUrl': imageUrl,
      'planName': planName,
      'tag': tag,
      'description': description,
      'startingPrice': startingPrice,
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map, String id) {
    return PlanModel(
      id: id,
      companyId: map['companyId'] as String,
      imageUrl: map['imageUrl'] as String,
      planName: map['planName'] as String,
      tag: map['tag'] as String,
      description: map['description'] as String,
      startingPrice: map['startingPrice'] as String,
    );
  }
//</editor-fold>
}
