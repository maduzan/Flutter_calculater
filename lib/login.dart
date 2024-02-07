// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String input = '';
  String result = '0';
  List<String> button = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '+',
    '*',
    '/',
    '=',
    '-',
    'AC'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 16, 16),
        appBar: AppBar(
          title: Text(
            'Calculater',
          ),
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.centerRight,
                      child: Text(
                        input,
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      )),
                  Container(
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.centerRight,
                      child: Text(
                        result,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(button[index]);
                  }),
            ))
          ],
        ));
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.black,
      onTap: () {
        setState(() {
          handlebutton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: Offset(-3, -3))
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  handlebutton(String text) {
    if (text == 'AC') {
      input = "";
      result = '0';
      return;
    }
    if (text == '=') {
      result = calculate();
      input = result;
      if (input.endsWith('.0')) {
        input = input.replaceAll('.0', '');
      }
      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', '');
      }
    }
    input = input + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(input);
      var evelute = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evelute.toString();
    } catch (e) {
      return 'error';
    }
  }
}
