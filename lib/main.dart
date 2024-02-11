import 'package:flutter/material.dart';

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

//It will return the particular button whose context is passed
Widget buttons(String buttontext, Color buttoncolor, Color textColor){
  return Container(
    child: ElevatedButton(
      onPressed: (){

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
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text('0', textAlign: TextAlign.left,  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 100
                    )
                    )
                    )
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