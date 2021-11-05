import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ykassa_app/repository.dart';

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
      ),
      home: MyPaid(),
    );
  }
}

class MyPaid extends StatefulWidget {
  const MyPaid({Key key}) : super(key: key);

  @override
  _MyPaidState createState() => _MyPaidState();
}

class _MyPaidState extends State<MyPaid> {
  final _formKey = GlobalKey<FormBuilderState>();
  static const platform = const MethodChannel('samples.flutter.dev/pay');

  bool loading = false;
  String messageResult;

  Future<void> _getPaidLevel(double value) async {
    try {
      final result = await platform.invokeMethod('payMethod', {'value': value});

      setState(() {
        loading = true;
      });

      print("!!!!!");
      print(result);
      print("!!!!!");

      await fetchPai(result, value);

      setState(() {
        messageResult = "Оплата проведена успешна!";
        loading = false;
      });

    } on PlatformException catch (e) {
      print("!!!! Failed to get paid level: '${e.message}'.");
      messageResult = "Не удалось произвести оплату";
      loading = false;
    } catch (e) {
      setState(() {
        messageResult = "Не удалось произвести оплату";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Пожертвовать",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                if (messageResult != null) Text(messageResult),

                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: FormBuilderTextField(
                    cursorColor: Colors.green[400],
                    name: 'cost',
                    initialValue: '0',
                    decoration: InputDecoration(
                      fillColor: Colors.green[400],
                      focusColor: Colors.green[400],
                      hoverColor: Colors.green[400],
                      labelText: "сумма",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(context,
                            errorText: "Обязательное поле!"),
                        FormBuilderValidators.integer(context,
                            errorText: "Введите число!"),
                        FormBuilderValidators.min(context, 10,
                            errorText: "Минимальная сумма 10"),
                        FormBuilderValidators.max(context, 1000,
                            errorText: "Максимальная сумма 1000"),
                      ],
                    ),
                  ),
                ),

                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      var formData = _formKey.currentState.value;

                      print(formData);

                      // setState(() {
                      //   loading = true;
                      // });

                      await _getPaidLevel(double.parse(formData['cost']));


                      // setState(() {
                      //   loading = false;
                      // });
                    }
                  },
                  height: 50,
                  minWidth: double.infinity,
                  color: Colors.green[400],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: loading
                      ? CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text(
                    "Оплатить",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
