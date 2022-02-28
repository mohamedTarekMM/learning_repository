class ProductModel {
  dynamic id;
  String? title;
  dynamic price;
  String? description;
  String? category;
  String? image;
  bool? inFavorite = false;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.inFavorite,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    inFavorite = json['inFavorite'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'title' : title,
      'price' : price,
      'description' : description,
      'category' : category,
      'image' : image,
      'inFavorite':inFavorite
    };
  }
}
/*static List<ProductModel> productModelFromSnapShot(List snapshot) {
    return snapshot.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Product {id:$id, title:$title,price:$price,description:$description,category:$category,image:$image,}';
  }*/

