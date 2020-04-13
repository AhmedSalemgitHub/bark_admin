import 'package:bark_admin/Models/order.dart';
import 'package:bark_admin/Models/product.dart';
import 'package:bark_admin/Models/sold.dart';
import 'package:bark_admin/Models/user.dart';
import 'package:bark_admin/Screens/brand_page.dart';
import 'package:bark_admin/Screens/order_page.dart';
import 'package:bark_admin/Screens/product_page.dart';
import 'package:bark_admin/Screens/sold_page.dart';
import 'package:bark_admin/Screens/user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bark_admin/Models/brand.dart';
import 'package:bark_admin/Models/categoty.dart';
import 'package:bark_admin/Screens/category_page.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Dashboard",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: DashboardWidget(),
    );
  }
}

// the main dashboard widget
class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var category = Provider.of<List<Category>>(context);
    var brand = Provider.of<List<Brand>>(context);
    var product = Provider.of<List<Product>>(context);
    var user = Provider.of<List<User>>(context);
    var order = Provider.of<List<Order>>(context);
    var sold = Provider.of<List<Sold>>(context);

    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: <Widget>[
        //The users Block
        DashboardBlock(
          color: Colors.red,
          label: "users",
          labelIcon: Icons.person,
          mainNumber: user.length ?? 0,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return UserPage();
              }),
            ));
          },
        ),
        //the categories Block
        DashboardBlock(
          color: Colors.red,
          label: "Categories",
          labelIcon: Icons.local_offer,
          mainNumber: category.length ?? 0,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return CategoryPage();
              }),
            ));
          },
        ),
        //temp
        DashboardBlock(
          color: Colors.red,
          label: "Brand",
          labelIcon: Icons.style,
          mainNumber: brand.length ?? 0,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return BrandPage();
              }),
            ));
          },
        ),
        //products Block
        DashboardBlock(
          color: Colors.red,
          label: "products",
          labelIcon: Icons.widgets,
          mainNumber: product.length ?? 0,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return ProductPage();
              }),
            ));
          },
        ),
        //current orders Block
        DashboardBlock(
          color: Colors.red,
          label: "Orders",
          labelIcon: Icons.add_shopping_cart,
          mainNumber: order.length ?? 0,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return OrderPage();
              }),
            ));
          },
        ),
        //Sold Block
        DashboardBlock(
          color: Colors.red,
          label: "Sold",
          labelIcon: Icons.beenhere,
          mainNumber: sold.length ?? 0,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context) {
                return SoldPage();
              }),
            ));
          },
        ),
      ],
    );
  }
}

// the main blocks structure to fill the grid
class DashboardBlock extends StatelessWidget {
  //the main constructor
  const DashboardBlock({
    Key key,
    @required this.color, // the main number color
    @required this.label, // the label above the main number
    @required this.pressFunction, // the function of the press on the tile
    @required this.labelIcon, // the icon
    @required this.mainNumber, // the main number
  }) : super(key: key);

  //the main constants
  final MaterialColor color;
  final String label;
  final Function pressFunction;
  final IconData labelIcon;
  final int mainNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  labelIcon,
                  color: Colors.blue,
                ),
                Text(label),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              mainNumber.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontSize: 40.0),
            ),
          ),
          onTap: pressFunction,
        ),
      ),
    );
  }
}
