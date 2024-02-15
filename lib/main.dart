import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
      );
    
  }
}

class Calculator extends StatefulWidget{
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>{

//variables
dynamic value = '0';
String numberone = '0';
String numbertwo = '0';
dynamic displayresult = 0;
dynamic finalresult = 0;
dynamic operation = '';
dynamic prevoperation = '';
bool val = false;
bool isOperation = false;

//calculator basic calculations logic
void calculations(buttontext){

  if(buttontext == 'AC'){
    numberone = '0';
    numbertwo = '0';
    displayresult = 0;
    finalresult = 0;
    val = false;
    isOperation = false;
  }

  else if(buttontext == '+/-')
{
  _signchange();
}

 else if(buttontext == '+' || buttontext == '-' || buttontext == '×' || buttontext == '÷' || buttontext == '%' || buttontext == '=' ){
 
 if(isOperation){
  operation = buttontext;
 }
 else{
  prevoperation = operation;
  operation = buttontext;
  val = true;
  if(prevoperation == '+'){
      _add();
    }
    else if (prevoperation == '-'){
      _subtract();
  }
  else if(prevoperation == '×'){
    _multiply();
  }
    else if(prevoperation == '÷'){
    _divide();
  }
    else if(prevoperation == '%'){
    _percent();
  }
 }
  isOperation = true;
}

else{
 if (!val) {
    numberone = numberone.startsWith('0') ? buttontext : numberone + buttontext;
    finalresult = numberone;
  } else {
    numbertwo = numbertwo.startsWith('0') ? buttontext : numbertwo + buttontext;
    finalresult = numbertwo;
  }
  isOperation = false;
}
_format(finalresult.toString());
setState(() {
  finalresult = finalresult;
  if(finalresult == 'Error'){
    displayresult = 'Error';
  }
  else{
    displayresult = displayresult;
  }
});
}

void _add(){
  finalresult = _parseNumber(numberone) + _parseNumber(numbertwo);
  numberone = finalresult.toString();
  numbertwo = '0';
}

void _subtract(){
  finalresult = _parseNumber(numberone) - _parseNumber(numbertwo);
  numberone = finalresult.toString();
  numbertwo = '0';
}

void _multiply(){
  finalresult = _parseNumber(numberone) * _parseNumber(numbertwo);
  numberone = finalresult.toString();
  numbertwo = '0';
}

void _divide(){
  if(_parseNumber(numbertwo)==0)  {
    finalresult = 'Error';
    numberone = '0';
    numbertwo = '0';
  }
  else{
    finalresult = _parseNumber(numberone) / _parseNumber(numbertwo);
    numberone = finalresult.toString();
    numbertwo = '0';
  }
}

void _percent(){
  finalresult = finalresult * 0.01;
  numberone = finalresult.toString();
}

void _signchange(){
  finalresult = finalresult*-1;
  numberone = finalresult.toString();
}

num _parseNumber(String number) {
  if (number.contains('.')) {
    return double.parse(number);
  } else {
    return int.parse(number);
  }
}

void _format(String number) {
  if(number != 'Error'){
    num numValue = num.parse(number);
    String str;
    if (numValue is int) {
      str = numValue.toString();
      str = str.length > 9 ? str.substring(0, 9) : str;
    } else {
      str = numValue.toStringAsFixed(9);
      List<String> parts = str.split('.');
      parts[0] = parts[0].length > 9 ? parts[0].substring(0, 9) : parts[0];
      parts[1] = parts[1].length > 9 ? parts[1].substring(0, 9) : parts[1];
      str = parts.join('.');
    }
    final formatter = NumberFormat("#,###.#########", "en_US");
    displayresult = formatter.format(double.parse(str));
  }
}

//It will return the particular button whose context is passed
Widget buttons(String buttontext, Color buttoncolor, Color textColor){
  return Container(
    child: ElevatedButton(
      onPressed: (){
          calculations(buttontext);
          Color temp = buttoncolor;
          buttoncolor = textColor;
          textColor = temp;
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.all(buttoncolor),
        padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
        fixedSize: MaterialStateProperty.all(Size(70, 70)),
      ),
      //styling text displayed on button
      child: Text(buttontext,
      style: TextStyle(
        fontSize: 30,
        color: textColor,
      )
      ),

      //styling button
     
    ),
  );
  
}

//Separate for '0' because it has a different shape
Widget zerobutton(String buttontext, Color buttoncolor, Color textColor){
  return Container(
    child: ElevatedButton(
      onPressed: (){
          calculations(buttontext);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(StadiumBorder()),
        backgroundColor: MaterialStateProperty.all(buttoncolor),
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(34, 20, 128, 20)),
      ),
      //styling text displayed on button
      child: Text(buttontext,
      style: TextStyle(
        fontSize: 30,
        color: textColor,
      )
      ),

      //styling button
     
    ),
  );
  
}


  Widget build(BuildContext context){
    return Scaffold(
      
      //assigning the background colour
      backgroundColor: Colors.black,

      appBar: AppBar(title: Text("Calculator"), backgroundColor: Colors.black),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            //creating the UI for the final answer that will be displayed
          Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: AutoSizeText(
          '$displayresult',
          textAlign: TextAlign.right,
          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 90),
          maxLines: 1,
        ),
      ),
    ),
  ],
),



              Row(
                
                //calling out button widget function(buttons) in order to display the buttons on the screen evenly
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  buttons('AC', Colors.grey, Colors.black),
                  buttons('+/-', Colors.grey, Colors.black),
                  buttons('%', Colors.grey, Colors.black),
                  buttons('÷', Colors.amber[700]!, Colors.white),
                ]
                ),
                SizedBox(
                  height: 18,
                ),
              Row(
                
                //calling out button widget function(buttons) in order to display the buttons on the screen evenly
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  buttons('7', Colors.grey[850]!, Colors.white),
                  buttons('8', Colors.grey[850]!, Colors.white),
                  buttons('9', Colors.grey[850]!, Colors.white),
                  buttons('×', Colors.amber[700]!, Colors.white),
                ]
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                
                //calling out button widget function(buttons) in order to display the buttons on the screen evenly
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  buttons('4', Colors.grey[850]!, Colors.white),
                  buttons('5', Colors.grey[850]!, Colors.white),
                  buttons('6', Colors.grey[850]!, Colors.white),
                  buttons('-', Colors.amber[700]!, Colors.white),
                ]
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                
                //calling out button widget function(buttons) in order to display the buttons on the screen evenly
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  buttons('1', Colors.grey[850]!, Colors.white),
                  buttons('2', Colors.grey[850]!, Colors.white),
                  buttons('3', Colors.grey[850]!, Colors.white),
                  buttons('+', Colors.amber[700]!, Colors.white),
                ]
                ),
                SizedBox(
                  height: 18,
                ),
                  Row(
                
                //calling out button widget function(buttons) in order to display the buttons on the screen evenly
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  zerobutton('0', Colors.grey[850]!, Colors.white),
                  buttons('.', Colors.grey[850]!, Colors.white),
                  buttons('=', Colors.amber[700]!, Colors.white),
                ]
                ),
                SizedBox(
                  height: 18,
                )
            
          ]
        ))

        );
  }
}