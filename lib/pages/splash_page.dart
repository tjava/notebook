import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback? onInitializationComplete;

  const SplashPage({Key? key, this.onInitializationComplete}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (_) => widget.onInitializationComplete!(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.3),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "from",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: SvgPicture.asset('assets/images/logo.svg'),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Text(
                            "Art Lab",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
