// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.success,
        this.message,
        this.product,
    });

    bool success;
    String message;
    List<Product> product;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        success: json["success"],
        message: json["message"],
        product: List<Product>.from(json["Product"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Product": List<dynamic>.from(product.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.id,
        this.name,
        this.description,
        this.stock,
        this.price,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String description;
    String stock;
    String price;
    int categoryId;
    DateTime createdAt;
    DateTime updatedAt;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        stock: json["stock"],
        price: json["price"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "category_id": categoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
