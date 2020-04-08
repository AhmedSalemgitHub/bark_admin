import 'package:bark_admin/Screens/Brands.dart';
import 'package:bark_admin/Screens/Products.dart';
import 'package:bark_admin/db/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'Screens/Categories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Park Admin'),
    );
  }
}

enum Page { dashboard, manage }
DatabaseService databaseService = DatabaseService();

List<Widget> listCategories(AsyncSnapshot snapshot) {
  return snapshot.data.documents.map<Widget>((document) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(document["name"]),
        ],
      ),
    );
  }).toList();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //the page identefier
  Page _selectedPage = Page.dashboard;

  // the used colors for active and inactive
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton.icon(
                  onPressed: () {
                    setState(() => _selectedPage = Page.dashboard);
                  },
                  icon: Icon(
                    Icons.dashboard,
                    color: _selectedPage == Page.dashboard ? active : notActive,
                  ),
                  label: Text("Dashboard"),
                ),
              ),
              Expanded(
                child: FlatButton.icon(
                  onPressed: () {
                    setState(() => _selectedPage = Page.manage);
                  },
                  icon: Icon(
                    Icons.sort,
                    color: _selectedPage == Page.manage ? active : notActive,
                  ),
                  label: Text("Manage"),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: _selectedPage == Page.dashboard
            ? DashboardWidget(
                color: Colors.red,
              )
            : ManageWidget(
                context: context,
              ));
  }
}

//the manage widget screen
class ManageWidget extends StatelessWidget {
  const ManageWidget({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    //the services used to communicate with firebase
    DatabaseService _databaseService = DatabaseService();

    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.change_history),
          title: Text("products List"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Products()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.add_circle),
          title: Text("Categories List"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Categories()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.speaker_notes),
          title: Text("Brands List"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Brands()));
          },
        ),
        Divider(),
      ],
    );
  }
}

// the main dashboard widget
class DashboardWidget extends StatelessWidget {
  const DashboardWidget({
    Key key,
    @required this.color,
  }) : super(key: key);

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: <Widget>[
        //The users Block
        DashboardBlock(
          color: color,
          label: "users",
          labelIcon: Icons.person,
          mainNumber: databaseService.countusers() ?? 0,
          pressFunction: () {},
        ),
        //the categories Block
        DashboardBlock(
          color: color,
          label: "Categories",
          labelIcon: Icons.library_books,
          mainNumber: 0,
          pressFunction: () {},
        ),
        //products Block
        DashboardBlock(
          color: color,
          label: "products",
          labelIcon: Icons.widgets,
          mainNumber: databaseService.countProducts() ?? 0,
          pressFunction: () {},
        ),
        //current orders Block
        DashboardBlock(
          color: color,
          label: "Orders",
          labelIcon: Icons.add_shopping_cart,
          mainNumber: 7,
          pressFunction: () {},
        ),
        //Sold Block
        DashboardBlock(
          color: color,
          label: "Sold",
          labelIcon: Icons.sentiment_satisfied,
          mainNumber: 7,
          pressFunction: () {},
        ),
        //temp
        DashboardBlock(
          color: color,
          label: "temp",
          labelIcon: Icons.access_time,
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
