class Product {
      final String id;
      final String name;
      final double price;
      final String brand;
      final String category;
      final String description;
      final String picture;
      final bool featured;

  Product({
      this.id,
      this.name,
      this.price,
      this.brand,
      this.category,
      this.description,
      this.picture,
      this.featured}) ;

  Product.fromJson(Map<String,dynamic> data) :
    id = data["id"],
    name = data["name"],
    price = data["price"],
    brand = data["brand"],
    category = data["category"],
    description = data["description"],
    picture = data["picture"],
    featured = data["featured"];
}