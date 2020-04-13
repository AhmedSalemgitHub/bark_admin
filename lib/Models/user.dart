class User {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String registerMethod;
  final int age;
  final String phone;
  final List orders;
  final List reviews;
  final List userCart;

  User(
      {this.id,
      this.name,
      this.age,
      this.email,
      this.orders,
      this.phone,
      this.photo,
      this.registerMethod,
      this.reviews,
      this.userCart});

  User.fromJson(Map<String, dynamic> data)
      : id = data['id'],
      name = data['name'],
      age = data['age'],
      email = data['email'],
      orders = data['orders'],
      phone = data['phone'],
      photo = data['photo'],
      registerMethod = data['registerMethod'],
      reviews = data['reviews'],
      userCart = data['userCart'];
}
