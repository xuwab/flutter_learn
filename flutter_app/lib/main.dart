import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:english_words/english_words.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/TestEvent.dart';

import 'model/TestModel.dart';

void main() => runApp(
    //1.test runapp
//  Center(
//    child: Text(
//      "Hello World!",
//      textDirection: TextDirection.ltr,
//    ),
//  )

    //2、custom app
//    App()

    //3、custom material app
    NavigatorAPP());

class NavigatorAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'home',
      routes: {'second': (context) => SecondScreen()},
      onUnknownRoute: (RouteSettings settings) =>
          MaterialPageRoute(builder: (context) => SecondScreen()),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("First"),
      ),
      body: RaisedButton(
        onPressed: () => {
          Navigator.pushNamed(context, 'second', arguments: 'hello i am first')
              .then((value) => print(value))
        },
        child: Text('push next', textDirection: TextDirection.ltr),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String msg  = ModalRoute.of(context).settings.arguments as String;
    print(msg);
    return Scaffold(
      appBar: AppBar(title: Text('Second')),
      body: RaisedButton(
        onPressed: () => {Navigator.pop(context,'i am from second')},
        child: Text('pop back', textDirection: TextDirection.ltr),
      ),
    );
  }
}

class MyCustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'my app',
      theme: ThemeData(primaryColor: Colors.yellow),
      home: CustomNotificationApp(),
    );
  }
}

class CustomNotification extends Notification {
  String msg;

  CustomNotification(this.msg);
}

class CustomNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: () => eventBus.fire(TestEvent("kulijiwa")),
      child: Text("Press Me"),
    );
  }
}

class CustomNotificationApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomNotificationAppState();
  }
}

EventBus eventBus = EventBus();

class CustomNotificationAppState extends State<CustomNotificationApp> {
  String _msg = "通知";

  StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    subscription = eventBus.on<TestEvent>().listen((event) {
      setState(() {
        _msg += "\n" + event.msg;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    // TODO: implement build
    return NotificationListener<CustomNotification>(
      onNotification: (notification) {
        setState(() {
          count++;
          print(_msg);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text(_msg), CustomNotificationWidget()],
      ),
    );
  }
}

class TransferDataApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransferDataAppState();
  }
}

class TransferDataAppState extends State<TransferDataApp> {
  int count = 0;

  void _increment() => setState(() {
        count++;
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CountContainer(
      increment: _increment,
      child: CountWidget(),
      state: this,
    );
  }
}

class CountContainer extends InheritedWidget {
  final Function increment;

  final TransferDataAppState state;

  static CountContainer of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CountContainer) as CountContainer;

  CountContainer(
      {Key key,
      @required Widget child,
      @required this.increment,
      @required this.state})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountContainer oldWidget) {
    // TODO: implement updateShouldNotify
    return state.count != oldWidget.state.count;
  }
}

class CountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    CountContainer container = CountContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Count Title'),
      ),
      body: Text('the count is ${container.state.count}'),
      floatingActionButton: FloatingActionButton(
        onPressed: container.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomerApp3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomerApp3State();
  }
}

class CustomerApp3State extends State<CustomerApp3> {
  ScrollController _controller;
  bool isToTop = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    _controller.addListener(() {});
    super.initState();
  }

  Widget getItem(BuildContext context, int index) {
    return Listener(
      onPointerCancel: (event) => {print('event $event')},
      onPointerMove: (event) => {print('event $event')},
      onPointerUp: (event) => {print('event $event')},
      onPointerDown: (event) => {print('event $event')},
      child: Container(
          height: 30,
          width: 100,
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: FlatButton(
            onPressed: () {
              print('dkasda');

              Scaffold.of(context).showSnackBar(
                new SnackBar(
                  content: new Text("Added to favorite"),
                  action: new SnackBarAction(
                    label: "UNDO",
                    onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                  ),
                ),
              );
            },
            child: Text('lalla'),
            color: Colors.red,
            textColor: Colors.blue,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, top: 40, right: 40),
              child: FloatingActionButton(
                onPressed: isToTop
                    ? () {
                        print(isToTop);
                        _controller.animateTo(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease);
                      }
                    : null,
                child: Text(
                  "Top",
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            ),
            Expanded(
                child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        print(notification.metrics.pixels);
                        if (notification.metrics.pixels > 100) {
                          setState(() {
                            isToTop = true;
                          });
                        } else if (notification.metrics.pixels < 100) {
                          setState(() {
                            isToTop = false;
                          });
                        }
                      }
                    },
                    child: ListView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) =>
                          getItem(context, index),
                      itemCount: 100,
                      itemExtent: 40,
                    )))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}

//class CustomMaterialApp2 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    TextStyle textStyleBlack = TextStyle(
//        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
//
//    TextStyle textStyleYellow = TextStyle(
//        color: Colors.yellow, fontWeight: FontWeight.normal, fontSize: 30);
//
//    return MaterialApp(
//      home: Scaffold(
//          backgroundColor: Colors.white,
//          appBar: AppBar(
//            title: Text(
//              "hello",
//              maxLines: 2,
//              style: TextStyle(color: Colors.red),
//            ),
//          ),
//          body: CustomScrollView(
//            slivers: <Widget>[
//              SliverAppBar(
//                title: Text("sliver title"),
//                floating: true,
//                flexibleSpace: FadeInImage.assetNetwork(
//                    placeholder: 'lib/assets/ali_landscape.png',
//                    image:
//                        "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1303636189,2885099528&fm=26&gp=0.jpg",
//                fit: BoxFit.cover,),
//                expandedHeight: 100,
//              ),
//              SliverList(
//                  delegate: SliverChildBuilderDelegate(
//                      (BuildContext context, int index) =>
//                          ListTile(title: Text('Item $index')),
//                      childCount: 200))
//            ],
//          )
//          ListView.separated(
//            separatorBuilder: (BuildContext context, int index){
//              if(index%2 == 0){
//                return Divider(height: 2,color: Colors.red,);
//              }else{
//                return Divider(height: 2,color: Colors.yellow,);
//              }
//            },
//            itemBuilder: (BuildContext context, int index){
//            return Column(
//              children: <Widget>[
//                ListTile(title: Text("title $index")),
////                Divider(height: 2,color: Colors.red,)
//              ],
//            );
//
//          },itemCount: 10)

//          ListView(
//            scrollDirection: Axis.horizontal,
//            itemExtent: 200,
//            children: <Widget>[
//              Container(
//                color: Colors.yellow,
//              ),
//              Container(
//                color: Colors.red,
//              ),
//              Container(
//                color: Colors.grey,
//              ),
//              Container(
//                color: Colors.green,
//              ),
//              Container(
//                color: Colors.blue,
//              )

//              ListTile(
//                leading: Icon(Icons.map),
//                title: Text('map'),
//                subtitle: Text('map'),
//              ),
//              ListTile(
//                leading: Icon(Icons.map),
//                title: Text('map'),
//                subtitle: Text('map'),
//              ),
//              ListTile(
//                leading: Icon(Icons.map),
//                title: Text('map'),
//                subtitle: Text('map'),
//      )
//            ],
//          )
//          Container(
//            margin: EdgeInsets.only(left: 30,top: 50),
//            child: Text.rich(
//              TextSpan(children: <TextSpan>[
//                TextSpan(text: "i am black \n", style: textStyleBlack),
//                TextSpan(text: "i am yellow \n", style: textStyleYellow),
//                TextSpan(text: "i am black \n", style: textStyleBlack),
//                TextSpan(text: "i am yellow ", style: textStyleYellow),
//              ]),
//            ),
//          )
//      FadeInImage.assetNetwork(placeholder: 'lib/assets/ali_landscape.png', image: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1303636189,2885099528&fm=26&gp=0.jpg")
//          ),
//      theme: ThemeData(primarySwatch: Colors.green),
//    );
//  }
//}

class CustomMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(TestModel("jake", "nana").name),
        ),
        body: ListWidget());
  }
}

class ListWidget extends StatelessWidget {
  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Image.network(
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565476747316&di=d6c0635fa4c77a2bf12c83115745fd05&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F13%2F22%2F16pic_1322578_b.jpg",
            height: 100,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            testModelList[index].name,
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            testModelList[index].id,
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: testModelList.length, itemBuilder: _itemBuilder);
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        "App",
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.green),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  handleValue(int value) {}

  handleError(error) {}

  handleComplete() {}

  handleFuture() {}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('paused');
    }
    if (state == AppLifecycleState.inactive) {
      print('inactive');
    }
    if (state == AppLifecycleState.resumed) {
      print('resumed');
    }
  }

//
//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//    print('didChangeDependencies');
//  }
//
//  @override
//  void didUpdateWidget(MyApp oldWidget) {
//    // TODO: implement didUpdateWidget
//    super.didUpdateWidget(oldWidget);
//    print('didUpdateWidget');
//  }

  @override
  Widget build(BuildContext context) {
//    Future<int> future = new Future(() => handleFuture());
//
//    future.then((value) => handleValue(value))
//    .catchError((error) => handleError(error))
//    .whenComplete(() => handleComplete());

    print('build');

    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: WordPair.random().asPascalCase),
      color: Colors.red,
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
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('initState');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  void _incrementCounter() => setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        _counter++;
      });

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '(测试热重载)You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//}
