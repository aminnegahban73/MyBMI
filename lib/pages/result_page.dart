import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String _height, _weight;
  ResultPage(this._height, this._weight);
  createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  double _result = 0;
  double _minWeight = 0;
  double _maxWeight = 0;
  double _diffWeight = 0;

  int _colorIndex = 0;

  String _bmiStatus = '';
  String _image = '';

  List<Color> _colorList = [
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.red[400]
  ];

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    calculateBMI();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('BMI'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            'شاخص توده بدنی شما: ${_result.toStringAsFixed(1)}',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '  :وضعیت',
                                style: TextStyle(fontSize: 25),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '$_bmiStatus',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: _colorList[_colorIndex],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      // child: FadeTransition(
                      //   opacity: animation,
                      // ),
                      child: FadeTransition(
                        opacity: animation,
                        child: Container(
                          child: Image.asset(_image),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'وزن مناسب برای شما براساس قدتان',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '.بین ${_minWeight.toStringAsFixed(1)} تا ${_maxWeight.toStringAsFixed(1)} کیلوگرم می‌باشد',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    setState(() {
      if (widget._height.isNotEmpty && widget._weight.isNotEmpty) {
        double height = double.parse(widget._height);
        double weight = double.parse(widget._weight);
        _result = weight / (height * height) * 10000;

        _minWeight = 18.5 * (height * height) / 10000;
        _maxWeight = 24.9 * (height * height) / 10000;

        _diffWeight = weight - _maxWeight;
        print(_diffWeight.toStringAsFixed(1));

        if (_result < 18.5) {
          _image = 'assets/img/1.png';
          _bmiStatus = "کمبود وزن";
          _colorIndex = 0;
        } else if (18.5 <= _result && _result < 25) {
          _image = 'assets/img/2.png';
          _bmiStatus = "نرمال";
          _colorIndex = 1;
        } else if (25 <= _result && _result < 30) {
          _image = 'assets/img/3.png';
          _bmiStatus = "اضافه وزن";
          _colorIndex = 2;
        } else if (30 <= _result && _result < 35) {
          _image = 'assets/img/4.png';
          _bmiStatus = "چاق";
          _colorIndex = 3;
        } else if (35 <= _result) {
          _image = 'assets/img/5.png';
          _bmiStatus = "خیلی چاق";
          _colorIndex = 4;
        }
      } else {
        _result = 0.0;
      }
    });
  }
}
