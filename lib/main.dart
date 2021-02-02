import 'package:flutter/material.dart';
import 'strings.dart';
import 'consts.dart';
import 'package:flame/flame.dart';
import 'package:flame/animation.dart' as animation;
import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/position.dart';
import 'package:flame/widgets/animation_widget.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'dart:ui' as ui;

animation.Animation globalAnim;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.images.loadAll(
      <String>['cat_run.png', 'cat_joy.png', 'dog_run.png', 'dog_joy.png']);
  final globalAnim = SpriteSheet(
    imageName: 'cat_run.png',
    columns: 4,
    rows: 5,
    textureWidth: 454,
    textureHeight: 384,
  ).createAnimation(0);
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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  animation.Animation animCatRun;
  animation.Animation animCatJoy;
  animation.Animation animCDogRun;
  animation.Animation animDogJoy;

  List<ui.Image> animImages;
  Future<List<ui.Image>> _preloadImages;

  @override
  void initState() {
    _preloadImages = Flame.images.loadAll(
        <String>['cat_run.png', 'cat_joy.png', 'dog_run.png', 'dog_joy.png']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COL_CREAM,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<ui.Image>>(
          future: _preloadImages,
          initialData: [],
          builder:
              (BuildContext context, AsyncSnapshot<List<ui.Image>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(
                  value: null,
                  valueColor: new AlwaysStoppedAnimation<Color>(COL_RED),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error Loading Images: ${snapshot.error}'),
              );
            } else {
              // animCatRun = animation.Animation.sequenced(
              //   'cat_run.png',
              //   20,
              //   amountPerRow: 4,
              //   textureWidth: 454,
              //   textureHeight: 384,
              //   stepTime: 0.05,
              // );
              animCatRun = globalAnim;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 350,
                    height: 400,
                    color: COL_TURQUOISE,
                    child: AnimationWidget(
                      animation: animCatRun,
                    ),
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
              );
            }
            ;
          },
        ),
      ),
    );
  }
}
