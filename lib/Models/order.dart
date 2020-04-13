class Order {
  final String id;
  final String name;

  Order({this.id,this.name});

  Order.fromJson(Map<String,dynamic> data) :
    id = data["id"],
    name = data["name"];
}