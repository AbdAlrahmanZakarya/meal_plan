class MealModel {
  final String planId;
  final String mealId;
  final String imageUrl;
  final String companyName;
  final String description;
  final String carb;
  final String mealName;
  final String protein;
  final String calorie;
  final String fat;
  final String weight;
  final String tag;
  final String kind;
  final List<Ingredients> ingredients;

//<editor-fold desc="Data Methods">
  MealModel({
    required this.mealId,
    required this.planId,
    required this.imageUrl,
    required this.companyName,
    required this.description,
    required this.carb,
    required this.mealName,
    required this.protein,
    required this.calorie,
    required this.fat,
    required this.ingredients,
    required this.weight,
    required this.tag,
    required this.kind,
  });

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> i = [];
    for (var element in ingredients) {
      i.add(element.toMap());
    }
    return {
      'mealName': mealName,
      'imageUrl': imageUrl,
      'companyName': companyName,
      'description ': description,
      'protein': protein,
      'carb': carb,
      'calorie': calorie,
      'fat': fat,
      'ingredients': i,
      'weight': weight,
      'tag': tag,
      'kind': kind,
    };
  }

  factory MealModel.fromMap(
    Map<String, dynamic> map, {
    required String planId,
    required String mealId,
  }) {
    return MealModel(
      mealId: mealId,
      planId: planId,
      description: map['description '] as String? ?? 'Temp Description',
      imageUrl: map['imageUrl'] as String,
      companyName: map['companyName'] as String,
      carb: map['carb'] as String,
      mealName: map['mealName'] as String,
      protein: map['protein'] as String,
      calorie: map['calorie'] as String,
      fat: map['fat'] as String,
      ingredients: List<Map<String, dynamic>>.from(map['ingredients'])
          .map((e) => Ingredients.fromMap(e))
          .toList(),
      weight: map['weight'] as String,
      tag: map['tag'] as String,
      kind: map['kind'] as String,
    );
  }

  MealModel copyWith({
    String? planId,
    String? mealId,
    String? imageUrl,
    String? companyName,
    String? description,
    String? carb,
    String? mealName,
    String? protein,
    String? calorie,
    String? fat,
    List<Ingredients>? ingredients,
    String? weight,
    String? tag,
    String? kind,
  }) {
    return MealModel(
        planId: planId ?? this.planId,
        mealId: mealId ?? this.mealId,
        imageUrl: imageUrl ?? this.imageUrl,
        companyName: companyName ?? this.companyName,
        description: description ?? this.description,
        carb: carb ?? this.carb,
        mealName: mealName ?? this.mealName,
        protein: protein ?? this.protein,
        calorie: calorie ?? this.calorie,
        fat: fat ?? this.fat,
        ingredients: ingredients ?? this.ingredients,
        weight: weight ?? this.weight,
        tag: tag ?? this.tag,
        kind: kind ?? this.kind);
  }

  @override
  String toString() {
    return 'MealModel{ carb: $carb, planId: $planId, mealId: $mealId, mealName: $mealName, companyName: $companyName, description: $description, imageUrl: $imageUrl, protein: $protein, calorie: $calorie, fat: $fat, ingredients: $ingredients, weight: $weight, tag: $tag, kind: $kind}';
  }
//</editor-fold>
}

class Ingredients {
  final String quantity;
  final String ingredientName;
  final String imageUrl;
  final String quantityUnit;

//<editor-fold desc="Data Methods">
  const Ingredients({
    required this.quantity,
    required this.ingredientName,
    required this.imageUrl,
    required this.quantityUnit,
  });

  @override
  String toString() {
    return 'Ingredients{ quantity: $quantity, ingredientName: $ingredientName, imageUrl: $imageUrl, quantityUnit: $quantityUnit,}';
  }

  Ingredients copyWith({
    String? quantity,
    String? ingredientName,
    String? imageUrl,
    String? quantityUnit,
  }) {
    return Ingredients(
      quantity: quantity ?? this.quantity,
      ingredientName: ingredientName ?? this.ingredientName,
      imageUrl: imageUrl ?? this.imageUrl,
      quantityUnit: quantityUnit ?? this.quantityUnit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'ingredientName': ingredientName,
      'imageUrl': imageUrl,
      'quantityUnit': quantityUnit,
    };
  }

  factory Ingredients.fromMap(Map<String, dynamic> map) {
    return Ingredients(
      quantity: map['quantity'] as String,
      ingredientName: map['ingredientName'] as String,
      imageUrl: map['imageUrl'] as String,
      quantityUnit: map['quantityUnit'] as String,
    );
  }

//</editor-fold>
}
