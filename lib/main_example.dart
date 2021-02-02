import 'dart:async';
import 'dart:developer';

import 'package:find_me_animals/consts.dart';
import 'package:flame/anchor.dart';
import 'package:flame/flame.dart';
import 'package:flame/animation.dart' as animation;
import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/position.dart';
import 'package:flame/widgets/animation_widget.dart';
import 'package:flame/widgets/sprite_widget.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

Future<List<animation.Animation>> _preloadAnimations() async {
  await Flame.images.loadAll(<String>['cat_run.png', 'cat_joy.png', 'dog_run.png', 'dog_joy.png']);

  animation.Animation _kAnimCatRun = animation.Animation.sequenced(
    'cat_run.png',
    20,
    amountPerRow: 4,
    textureWidth: 454,
    textureHeight: 384,
    stepTime: 0.05,
  );

  animation.Animation _kAnimCatJoy = animation.Animation.sequenced(
    'cat_joy.png',
    10,
    amountPerRow: 4,
    textureWidth: 455,
    textureHeight: 436,
    stepTime: 0.1,
  );

  animation.Animation _kAnimDogRun = animation.Animation.sequenced(
    'dog_run.png',
    20,
    amountPerRow: 5,
    textureWidth: 242,
    textureHeight: 368,
    stepTime: 0.05,
  );

  animation.Animation _kAnimDogJoy = animation.Animation.sequenced(
    'dog_joy.png',
    10,
    amountPerRow: 5,
    textureWidth: 254,
    textureHeight: 425,
    stepTime: 0.1,
  );

  return  [_kAnimCatRun, _kAnimCatJoy, _kAnimDogRun, _kAnimDogJoy];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Me!',
      theme: ThemeData(
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position _position = Position(256.0, 256.0);
  //List<animation.Animation> _catAnims = [_kAnimCatRun, _kAnimCatJoy]; 
  List<animation.Animation> _catAnims; 
  int _animIndex = 0;
  Future<List<animation.Animation>> _fetchAnimFuture;

  @override
  void initState() {
    _fetchAnimFuture = _preloadAnimations();
    super.initState();
  }

  Widget buildLoading(){
    return Center(
      child: CircularProgressIndicator(
        value: null,
        valueColor:
            new AlwaysStoppedAnimation<Color>(COL_BLUE),
      ),
    );
  }

  Widget buildError(String errorMsg){
    return Center(
      child: Text(
        'Error Loading Animation: ${errorMsg}',
      ),
    );
  }

  Widget buildMainScr(){
     return Center(
       child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Tap the Cat to change animation!'),
              Container(
                width: 350,
                height: 500,
                child: GestureDetector(
                  child: AnimationWidget(animation: _catAnims[_animIndex]),
                  onTap: switchAnimations,
                ),
              ),

            ],
          ),
        ),
     );
  }

  void switchAnimations(){

    setState(() {
      if(_animIndex == _catAnims.length -1){
        _animIndex = 0;
      } else {
        _animIndex ++;
        print("Tapped the animation!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Animation as a Widget Demo'),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder<List<animation.Animation>> (
            future: _fetchAnimFuture,
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot<List<animation.Animation>> snapshot){
              if (snapshot.connectionState != ConnectionState.done) {
                return buildLoading();
              }
              if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              if( snapshot.hasData ) {
                _catAnims = snapshot.data;
                return buildMainScr();
              }
              return Text("Meh????");
            },),
        ),
      ],),
      // body: Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text('Tap the Cat to change animation!'),
      //         Container(
      //           width: 350,
      //           height: 500,
      //           child: GestureDetector(
      //             child: AnimationWidget(animation: _catAnims[_animIndex]),
      //             onTap: switchAnimations,
      //           ),
      //         ),

      //       ],
      //     ),
      //   ),
      // ),

    );
  }
}
