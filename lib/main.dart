import 'package:bark_admin/Screens/Products.dart';
import 'package:bark_admin/db/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    //text controllers for the dialogs
    TextEditingController categoryController = TextEditingController();
    TextEditingController brandController = TextEditingController();

    //the form global keys used in the dialogs
    GlobalKey<FormState> _categoryFormKey = GlobalKey();
    GlobalKey<FormState> _brandFormKey = GlobalKey();

    //the services used to communicate with firebase
    DatabaseService _databaseService = DatabaseService();

    void _categoryAlert() {
      var alert = new AlertDialog(
        content: Form(
          key: _categoryFormKey,
          child: TextFormField(
            controller: categoryController,
            validator: (value) {
              if (value.isEmpty) {
                return 'category cannot be empty';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(hintText: "add category"),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              if (categoryController.text != null) {
                _databaseService.createCategory(categoryController.text);
              }
              Fluttertoast.showToast(msg: "category created");
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text('add'),
          ),
          FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('cancel'),
          ),
        ],
      );
      showDialog(context: context, builder: (_) => alert);
    }

    void _brandAlert() {
      var alert = new AlertDialog(
        content: Form(
          key: _brandFormKey,
          child: TextFormField(
            controller: brandController,
            validator: (value) {
              if (value.isEmpty) {
                return 'brand cannot be empty';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(hintText: "add brand"),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              if (brandController.text != null) {
                _databaseService.createBrand(brandController.text);
              }
              Fluttertoast.showToast(msg: "brand created");
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text('add'),
          ),
          FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('cancel'),
          ),
        ],
      );
      showDialog(context: context, builder: (_) => alert);
    }

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
          title: Text("Add Category"),
          onTap: () {
            _categoryAlert();
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.category),
          title: Text("Category List"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text("Add Brand"),
          onTap: () {
            _brandAlert();
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.library_books),
          title: Text("Brand list"),
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
          mainNumber: "7",
          pressFunction: () {},
        ),
        //the categories Block
        DashboardBlock(
          color: color,
          label: "Categories",
          labelIcon: Icons.library_books,
          mainNumber: "7",
          pressFunction: () {},
        ),
        //products Block
        DashboardBlock(
          color: color,
          label: "products",
          labelIcon: Icons.widgets,
          mainNumber: "7",
          pressFunction: () {},
        ),
        //current orders Block
        DashboardBlock(
          color: color,
          label: "Orders",
          labelIcon: Icons.add_shopping_cart,
          mainNumber: "7",
          pressFunction: () {},
        ),
        //Sold Block
        DashboardBlock(
          color: color,
          label: "Sold",
          labelIcon: Icons.sentiment_satisfied,
          mainNumber: "7",
          pressFunction: () {},
        ),
        //temp
        DashboardBlock(
          color: color,
          label: "temp",
          labelIcon: Icons.access_time,
          mainNumber: "7",
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
  final String mainNumber;

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
              mainNumber,
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
