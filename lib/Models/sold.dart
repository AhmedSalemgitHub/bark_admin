class Sold {
  final String id;
  final String name;

  Sold({this.id,this.name});

  Sold.fromJson(Map<String,dynamic> data) :
    id = data["id"],
    name = data["name"];
}