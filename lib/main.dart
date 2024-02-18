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

//variable declarations
dynamic value = '0';
String numberone = '0'; //first number
String numbertwo = '0'; //second number
dynamic displayresult = 0; //displayed output on screen
dynamic finalresult = 0; //final output
dynamic operation = ''; //current operation
dynamic prevoperation = ''; //previous operation
bool val = false;
bool isOperation = false; 
dynamic lastpressed = ''; //last pressed value
String tempnumber = '0'; //Store value of numbertwo in case equals is pressed consecutively

//calculator basic calculations logic
void calculations(buttontext){
  lastpressed = buttontext;

  //when button AC is pressed
  if(buttontext == 'AC'){
    numberone = '0';
    numbertwo = '0';
    tempnumber = '0';
    displayresult = 0;
    finalresult = 0;
    val = false;
    isOperation = false;
  }

//conditions for '+/-' and '%
  else if(buttontext == '+/-' || buttontext == '%')
{
 if(buttontext == '+/-') _signchange();
 else  _percent();
}

//Conditions for other four basic operations ('+', '-', '×', '÷')
 else if(buttontext == '+' || buttontext == '-' || buttontext == '×' || buttontext == '÷' || buttontext == '=' ){
 
 //Considering the last operation in series of operations without any number
 if(isOperation && !(buttontext=='=' && operation=='=')){
  operation = buttontext;
 }
 else{
  if(!(buttontext=='=' && operation=='=')){
  prevoperation = operation;
  operation = buttontext;
  }
  else{
    numbertwo = tempnumber;
  }
  print(prevoperation + " " + numberone + " "+numbertwo);
  val = true;
  //Checking which  type of operation it is (addition, subtraction, multiplication, division)
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
 }
  isOperation = true;
}

//taking input of numberone and numbertwo
//condition: not contain more than one decimal
else{
 if (!val) {
  if (!(numberone.contains('.') && buttontext == '.'))
    numberone = numberone.startsWith('0') ? buttontext : numberone + buttontext;
    finalresult = numberone;
  } 
  else {
    if (!(numbertwo.contains('.') && buttontext == '.'))
    numbertwo = numbertwo.startsWith('0') ? buttontext : numbertwo + buttontext;
    finalresult = numbertwo;
  }

  isOperation = false;
}

//formatting according to calculator format
_format(finalresult.toString());

//setting state of final result and result to be displayed on screen
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

//method of addition
void _add(){
  finalresult = _parseNumber(numberone) + _parseNumber(numbertwo);
  numberone = finalresult.toString();
  tempnumber = numbertwo;
  numbertwo = '0';
}

//method of subtraction
void _subtract(){
  finalresult = _parseNumber(numberone) - _parseNumber(numbertwo);
  numberone = finalresult.toString();
  tempnumber = numbertwo;
  numbertwo = '0';
}

//method of multiplication
void _multiply(){
  finalresult = _parseNumber(numberone) * _parseNumber(numbertwo);
  numberone = finalresult.toString();
  tempnumber = numbertwo;
  numbertwo = '0';
}

//method of division
void _divide(){

  //handling divide by zero
  if(_parseNumber(numbertwo)==0)  {
    finalresult = 'Error';
    numberone = '0';
    numbertwo = '0';
    tempnumber = '0';
  }
  else{
    finalresult = _parseNumber(numberone) / _parseNumber(numbertwo);
    numberone = finalresult.toString();
    tempnumber = numbertwo;
    numbertwo = '0';
  }
}

//method of percentage
void _percent(){
  finalresult = finalresult * 0.01;
  numberone = finalresult.toString();
}

//method of sign change
void _signchange(){
  finalresult = finalresult*-1;
  numberone = finalresult.toString();
}

//making number double or int as per number format
num _parseNumber(String number) {
  if (number.contains('.')) {
    return double.parse(number);
  } else {
    return int.parse(number);
  }
}

//formatting number according to calculator format
void _format(String number) {
  if(number != 'Error'){
    if(number.endsWith('.') ){
      displayresult = number;
    }
    else{
    num numValue = num.parse(number);
    String str;
    if (numValue.abs() > 100000000 || (numValue.abs() < 0.000000001 && numValue.abs() > 0)) {
      // Use scientific notation for very large and very small numbers
      displayresult = numValue.toStringAsExponential(9);
    } else{
      //number formatting method depending on double or int
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
}
}


//It will return the particular button whose context is passed
Widget buttons(String buttontext, Color buttoncolor, Color textColor){
  //Some specific changes to some buttoms when they are pressed
  bool colorcondition = (buttontext==lastpressed) && (buttontext == '+' || buttontext == '-' || buttontext == '×' || buttontext == '÷');
  //AC turned to 'C' when a digit is entered
  bool textcondition = (buttontext == 'AC' && numbertwo != '0') || (buttontext == 'AC' && numberone != '0');
  return Container(
    child: ElevatedButton(
      onPressed: (){
          calculations(buttontext);
      },
      //button styling
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.all(!colorcondition ? buttoncolor : textColor),
        padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
        fixedSize: MaterialStateProperty.all(Size(70, 70)),
      ),
      //styling text displayed on button
      child: Text((textcondition ? 'C' : buttontext),
      style: TextStyle(
        fontSize: 30,
        color: (!colorcondition ? textColor : buttoncolor),
      )
      ),
     
    ),
  );
  
}

//Separate widget for '0' because it has a different shape
Widget zerobutton(String buttontext, Color buttoncolor, Color textColor){
  return Container(
    child: ElevatedButton(
      onPressed: (){
          calculations(buttontext);
      },
      //button styling
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

    ),
  );
  
}


  Widget build(BuildContext context){
    return Scaffold(
      
      //assigning the background colour
      backgroundColor: Colors.black,

      appBar: AppBar(backgroundColor: Colors.black),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        //creating one column and 5 rews witinin it
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