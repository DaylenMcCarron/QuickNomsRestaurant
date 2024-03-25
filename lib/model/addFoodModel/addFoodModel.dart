import 'dart:convert';

class AddFoodModel {
  String name;
  String restaurantUID;
  DateTime uploadTime;
  String foodID;
  String description;
  String foodImageURL;
  bool isVegetarian;
  String price;
  AddFoodModel({
    required this.name,
    required this.restaurantUID,
    required this.uploadTime,
    required this.foodID,
    required this.description,
    required this.foodImageURL,
    required this.isVegetarian,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "restaurantUID": restaurantUID,
      "uploadTime": uploadTime,
      "foodID": foodID,
      "description": description,
      "foodImageURL": foodImageURL,
      "isVegetarian": isVegetarian,
      "price": price,
    };
  }

  factory AddFoodModel.fromMap(Map<String, dynamic> map) {
    return AddFoodModel(
      name: map['name'] as String,
      restaurantUID: map['resturantUID'] as String,
      uploadTime: map['uploadTime'] as DateTime,
      foodID: map['foodID'] as String,
      description: map['description'] as String,
      foodImageURL: map['foodImageURL'] as String,
      isVegetarian: map['isVegetrain'] as bool,
      price: map['price'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory AddFoodModel.fromJson(String source) =>
      AddFoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
