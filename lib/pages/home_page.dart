import 'package:flutter/material.dart';
import 'package:my_bmi/pages/result_page.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  TextEditingController _heightController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();

  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Text('BMI Demo'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/bg.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop)),
            ),
            alignment: Alignment.topCenter,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(3),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        validator: _ageValidate,
                                        controller: _ageController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'سن',
                                          hintText: 'مثلا 25 سال',
                                          icon: Icon(Icons.person_outline),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        validator: _heightValidate,
                                        controller: _heightController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'قد',
                                          hintText: 'مثلا 176 سانتی‌متر',
                                          icon: Icon(Icons.insert_chart),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        validator: _weightValidate,
                                        controller: _weightController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'وزن',
                                          hintText: 'مثلا 58 کیلوگرم',
                                          icon: Icon(Icons.line_weight),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.pink,
                              child: MaterialButton(
                                onPressed: () {
                                  _validateInputsAndSubmit();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  'محاسبه',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Material(
                              color: Colors.orange,
                              
                              borderRadius: BorderRadius.circular(20),
                              child: MaterialButton(
                                onPressed: clearText,
                                child: Text('پاک کردن'),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 30.0),
                          //   child: Text(
                          //     '${result.toStringAsFixed(1)}',
                          //     style: TextStyle(fontSize: 23),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10.0),
                          //   child: Text(
                          //     '$_weightStatus',
                          //     style: TextStyle(fontSize: 23),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearText() {
    _ageController.text = "";
    _heightController.text = "";
    _weightController.text = "";
   

  }

  String _ageValidate(String value) {
    if (value.isEmpty) {
      return "سن خود را وارد کنید";
    } else if (value.length > 3) {
      return "سن بیش از 3 رقم مجاز نیست";
    }
    return null;
  }

  String _heightValidate(String value) {
    if (value.isEmpty) {
      return "قد خود را وارد کنید";
    } else if (int.parse(value) > 250) {
      return "رقم وارد شده اشتباه است";
    }
    return null;
  }

  String _weightValidate(String value) {
    if (value.isEmpty) {
      return "وزن خود را وارد کنید";
    } else if (int.parse(value) > 300) {
      return "رقم وارد شده اشتباه است";
    }
    return null;
  }

  void _validateInputsAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultPage(_heightController.text, _weightController.text),
        ),
      );
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }
}
