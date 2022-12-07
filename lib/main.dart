import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calculator(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      child: RaisedButton(
        onPressed: (){
          //TODO add function for button press
            calculation(btntxt);
        },
      child: Text(btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor
        ),
      ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10),
                child: Text(text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                  fontSize: 100),),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculator('AC', Colors.grey, Colors.black),
                calculator('+/-', Colors.grey, Colors.black),
                calculator('%', Colors.grey, Colors.black),
                calculator('/', Colors.orangeAccent, Colors.white),
              ],
            ),
              SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculator('7', Color(0xff292929), Colors.white),
                calculator('8', Color(0xff292929), Colors.white),
                calculator('9', Color(0xff292929), Colors.white),
                calculator('x', Colors.orangeAccent, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculator('4', Color(0xff292929), Colors.white),
                calculator('5', Color(0xff292929), Colors.white),
                calculator('6', Color(0xff292929), Colors.white),
                calculator('-', Colors.orangeAccent, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculator('1', Color(0xff292929), Colors.white),
                calculator('2', Color(0xff292929), Colors.white),
                calculator('3', Color(0xff292929), Colors.white),
                calculator('+', Colors.orangeAccent, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    onPressed: (){

                    },
                    shape: StadiumBorder(),
                child: Text("0", style: TextStyle(
                  fontSize: 35,
                  color: Colors.white
                ),),
                color: Color(0xff292929),),
                calculator('.', Color(0xff292929), Colors.white),
                calculator('=', Colors.orangeAccent, Colors.white),
              ],
            )
          ],

        ),
      ),
    );
  }
  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    }
    else if( opr == '=' && btnText == '=') {
      if(preOpr == '+') {
        finalResult =  add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result ;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }
    else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });

  }

  String add() {

      result = (numOne + numTwo).toString();
      numOne = double.parse(result);
      return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}
