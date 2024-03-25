class AddFoodModel {
  String name;
  String description;
  String foodImageURL;
  bool isVegetarian;
  String price;
  AddFoodModel({
    required this.name,
    required this.description,
    required this.foodImageURL,
    required this.isVegetarian,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "description": description,
      "foodImageURL": foodImageURL,
      "isVegetarian": isVegetarian,
      "price": price,
    };
  }
}
