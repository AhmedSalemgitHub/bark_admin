import 'package:bark_admin/Models/brand.dart';
import 'package:bark_admin/Models/categoty.dart';
import 'package:bark_admin/Screens/Categories.dart';
import 'package:bark_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  final FirestoreService _db = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(create: (BuildContext context) => _db.getCategory()),
        StreamProvider(create: (BuildContext context) => _db.getBrand()),
      ],
      child: MaterialApp(
        title: 'Park Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            //Home(),
            MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.red),
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
          mainNumber: 0,
          pressFunction: () {},
        ),
        //the categories Block
        DashboardBlock(
          color: Colors.red,
          label: "Categories",
          labelIcon: Icons.library_books,
          mainNumber: category.length,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context){
                return Categories();
              }),
            ));
          },
        ),
        //temp
        DashboardBlock(
          color: Colors.red,
          label: "Brand",
          labelIcon: Icons.access_time,
          mainNumber: brand.length,
          pressFunction: () {
            Navigator.push(context, MaterialPageRoute(
              builder: ((context){
                return Categories();
              }),
            ));
          },
        ),
        //products Block
        DashboardBlock(
          color: Colors.red,
          label: "products",
          labelIcon: Icons.widgets,
          mainNumber: 0,
          pressFunction: () {},
        ),
        //current orders Block
        DashboardBlock(
          color: Colors.red,
          label: "Orders",
          labelIcon: Icons.add_shopping_cart,
          mainNumber: 7,
          pressFunction: () {},
        ),
        //Sold Block
        DashboardBlock(
          color: Colors.red,
          label: "Sold",
          labelIcon: Icons.sentiment_satisfied,
          mainNumber: 7,
          pressFunction: () {},
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
                Icon(labelIcon),
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
