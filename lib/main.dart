import 'package:flutter/material.dart';
import 'strings.dart';
import 'consts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: COL_RED,
          textTheme: ButtonTextTheme.normal,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.white,
                primary: Colors.white,
              ),
        ),
        backgroundColor: COL_CREAM,
        primaryColor: COL_RED,
        brightness: Brightness.light,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: COL_BLUE,
              displayColor: COL_BLUE,
            ),
      ),
      home: MyHomePage(title: 'Find Me Animals'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COL_CREAM,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("images/cat_run.png"),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.0),
                side: BorderSide(color: COL_RED),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 50,
              ),
              child: Text(
                AppLoc.instance.get(TXT_HIDE),
                style: TextStyle(
                  color: COL_CREAM,
                  fontSize: 24,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
