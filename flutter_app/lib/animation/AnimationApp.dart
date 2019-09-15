import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MyAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'animation',
      theme: ThemeData(primaryColor: Colors.yellow),
      home: DefaultPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(children: [
            NormalAnimationPage(),
            NormalAnimationPage(),
            NormalAnimationPage(),
            NormalAnimationPage(),
          ]),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: '普通动画',
              ),
              Tab(
                icon: Icon(Icons.rss_feed),
                text: 'build动画',
              ),
              Tab(
                icon: Icon(Icons.perm_identity),
                text: 'widget动画',
              ),
              Tab(
                icon: Icon(Icons.message),
                text: 'hero动画',
              ),
            ],
            unselectedLabelColor: Colors.blueGrey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.green,
          ),
        ));
  }
}

class NormalAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NormalAnimateState();
  }
}

class NormalAnimateState extends State<NormalAnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

//    CurvedAnimation curvedAnimation
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);

    animation = Tween(begin: 50.0, end: 200.0).animate(curvedAnimation);
//      ..addListener(() => setState(() {}))
//      ..addStatusListener((status) {
//        if (status == AnimationStatus.completed) {
//          animationController.reverse(); // 动画结束时反向执行
//        } else if (status == AnimationStatus.dismissed) {
//          animationController.forward(); // 动画反向执行完毕时，重新执行
//        }
//      });

    animationController.forward();

    animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child: FlutterLogo(),
        builder: (BuildContext context, Widget child) {
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

class MyAnimationWidget extends AnimatedWidget {
  MyAnimationWidget({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        width: animation.value,
        height: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

const platformChannel = MethodChannel('mychannel');

class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
//    return Scaffold(
//        body: GestureDetector(
//      // 手势监听点击
//      child: Hero(
//          tag: 'hero', // 设置共享 tag
//          child: Container(width: 100, height: 100, child: FlutterLogo())),
//      onTap: () {
//        //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Page2()));// 点击后打开第二个页面
////        Future(() => print('future')).then((value) => print('then'));
////        scheduleMicrotask(() => print('microTask'));
//        initPlatFormChannel();
//        testMulPlatform();
//      },
//    ));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: 200,
        height: 200,
        child: NativeView(),
      ),
    );
  }

  getNetworkInfo() async {
    var httpClient = HttpClient();
    httpClient.idleTimeout = Duration(seconds: 5);

    var uri = Uri.parse("https://flutter.dev");
    var request = await httpClient.getUrl(uri);
    request.headers.add("user-agent", "Custom-UA");

    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      print(await response.transform(utf8.decoder).join());
    } else {
      print('${response.statusCode}');
    }
  }

  testHttp() async {
    var client = http.Client();

    var uri = Uri.parse("https://flutter.dev");

    http.Response response =
        await client.get(uri, headers: {"user-agent": "Custom-UA"});

    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
    } else {
      print('${response.statusCode}');
    }
  }

  testMyDio() async {
    var dio = Dio();

    var response = await dio.get("https://flutter.dev",
        options: Options(headers: {"user-agent": "Custom-UA"}));

    if (response.statusCode == HttpStatus.ok) {
      print(response.data.toString());
    } else {
      print('${response.statusCode}');
    }
  }

  testMulPlatform() async {
    int result;
    try {
      result = await platformChannel.invokeMethod("toast");
    } catch (e, s) {
      print(s);
      result = -1;
    }

    print(result == -1 ? "error" : "success");
  }

  initPlatFormChannel() {
    platformChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'flutter') {
        return await nativeCallFlutter(call.arguments);
      }

      return "no such method";
    });
  }

  Future<String> nativeCallFlutter(String str) async {
    print('i am from flutter  ${str}');
    return 'success';
  }
}

class NativeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: "androidview",
      );
    }
    return UiKitView(viewType: "iosview");
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    Future<Database> database = openDatabase(
//
//    );
    return Scaffold(
        body: Hero(
            tag: 'hero', // 设置共享 tag
            child: Container(width: 300, height: 300, child: FlutterLogo())));
  }
}

class NativeViewController {
  MethodChannel _channel;
  onCreate(int id) {
    _channel = MethodChannel('nativeview_$id');
  }

  changeBackgroundColor() async
  {
    _channel.invokeMethod('changeBackgroundColor',{"r":0,"g":255,"b":0});
  }
}

class DefaultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>DefaultState();
}

class DefaultState extends State<DefaultPage> {
  NativeViewController controller;
  @override
  void initState() {
    controller = NativeViewController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellowAccent,
        appBar: AppBar(title: Text("Default Page")),
        body:  Center(
          child: Container(width: 200, height:200,
              child: SampleView(controller: controller)),
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.change_history), onPressed: ()=>controller.changeBackgroundColor())

    );
  }
}

class SampleView extends StatefulWidget {
  const SampleView({
    Key key,
    this.controller,
  }) : super(key: key);

  final NativeViewController controller;

  @override
  State<StatefulWidget> createState() => SampleViewState();
}

class SampleViewState extends State<SampleView> {

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'androidview',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return UiKitView(viewType: 'iosview',
          onPlatformViewCreated: _onPlatformViewCreated
      );
    }
  }

  _onPlatformViewCreated(int id)=> widget.controller?.onCreate(id);
}

// 声明了一个延迟 3 秒返回 Hello 的 Future，并注册了一个 then 返回拼接后的 Hello 2019
//Future<String> fetchContent() =>
//    Future<String>.delayed(Duration(seconds:3), () => "Hello")
//        .then((x) => "$x 2019");
//
//main() async{
//  print(await fetchContent());// 等待 Hello 2019 的返回
//}
