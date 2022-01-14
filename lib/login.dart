import 'package:flutter/material.dart';
import 'package:recording_assign/main.dart';

class Login extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        primarySwatch: Colors.green,

        // Define the default font family.
        fontFamily: 'Nunito',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
          headline6: TextStyle(fontSize: 14.0),
          // headline6: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Nunito'),
        ),
      ),
      home: Body(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Body extends StatefulWidget {
  // const Body({Key? key}) : super(key: key);
  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>
{
  @override
  Widget build(BuildContext context) {

    TextEditingController inputController = new TextEditingController();

    final textField1 = FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'Please provide your number',
        style: TextStyle(fontSize: 28, fontFamily: 'Nunito'),
      )
    );

    final mobileNumberField = TextFormField(
      obscureText: false,
      controller: inputController,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign. center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone Number",
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: Colors.green, width: 2.0))),
    );
    
    final textField2 = Flexible(
      child: Text(
        'We will send an OTP to verify this number',
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        style: TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'Nunito'),
        // style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    final continueButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        // color: Theme.of(context).primaryColor,
        // minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
      ),
    );
    
    final card2 = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: Theme.of(context).primaryColor,
      color: Colors.black,
      child: MaterialButton(
        // color: Theme.of(context).primaryColor,
        // minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/google_image.png'),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text("Continue with Google", style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),)
            ],
          ),
        ),
    ),
  );

    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.\
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        leading: IconButton(icon:Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
          onPressed:() => MyApp(),
          // onPressed:() => Navigator.pop(context),
        )
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  textField1,
                  SizedBox(height: 100.0),
                  mobileNumberField,
                  SizedBox(height: 45.0),
                  textField2,
                  SizedBox(height: 45.0),
                  continueButon,
                  SizedBox(height: 100.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(color: Colors.grey)
                      ),       

                      Text('Or', style: TextStyle(color: Colors.grey)),        

                      Expanded(
                          child: Divider(color: Colors.grey)
                      ),
                    ]
                  ),

                  // SizedBox(height: 160.0),
                  SizedBox(height: 45.0),
                  card2,
                ],
              ),
          ),
        ),
      ),
    );
  }
}