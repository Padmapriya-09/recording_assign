import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recording_assign/login.dart';
// import 'package:responsive_framework/responsive_framework.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (context, widget) => ResponsiveWrapper.builder(
      //   BouncingScrollWrapper.builder(context, Widget),
      // builder: (context, widget) => ResponsiveWrapper.builder(
      //   Body(),
      //   maxWidth: 1200,
      //   minWidth: 450,
      //   defaultScale: true,
      //   breakpoints: [
      //     ResponsiveBreakpoint.resize(480, name: MOBILE),
      //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //     ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      //   ],
      //   background: Container(color: Color(0xFFF5F5F5))
      // ),
      // initialRoute: "/",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        // Define the default brightness and colors.
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
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
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
    // return Text('How Are You?');
    // final mymodel = context.watch<myModel>();
    TextStyle style = TextStyle(fontFamily: 'Nunito', fontSize: 20.0);

    TextEditingController inputController = new TextEditingController();
    String code="";
    CollectionReference collection = FirebaseFirestore.instance.collection('invite-codes');
    
    void onValue(String code) async{
      var result;

      var doc = await collection.doc('invite-codes').get();
      if(doc.exists){
        Map<String, dynamic> map = doc.data();
        if(map.containsValue(code)){
          result = {'status': true, 'message': 'Successful'};
          print(result);

          Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
        }
        else
        {
          result = {'status': false,'message': 'Failure'};
          print(result);

          Timer timer = Timer(Duration(milliseconds: 3000), (){
            Navigator.of(context, rootNavigator: true).pop();
          });
          showDialog(
            context: context,
            builder: (context) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: new Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                        child:  Center(
                          child: Text(
                            'Invalid code, Please try again',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
              );
            }
          ).then((value){
            // dispose the timer in case something else has triggered the dismiss.
            timer?.cancel();
            timer = null;
          });
        }
      }
    }

    final textField1 = FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'Continue with invite code',
        style: TextStyle(fontSize: 32, fontFamily: 'Nunito',),
      )
    );
    final inviteCodeField = TextFormField(
      obscureText: false,
      keyboardType: TextInputType.number,
      // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      controller: inputController,
      // onSaved: (value) => code = value,
      style: TextStyle(fontSize: 20),
      // style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign. center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Add Invite Code",
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: Colors.green, width: 2.0))),
    );
    final continueButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        // color: Theme.of(context).primaryColor,
        // minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState((){
            code=inputController.text;
            print(code);
            onValue(code);
          });
        },
        child: Text("Continue",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
      ),
    );
    final textField2 = Text(
      'No invite code?',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline2,
      // style: const TextStyle(fontWeight: FontWeight.bold),
    );
    final textField3 = FittedBox(
      fit: BoxFit.contain,
      child: Text(
        'If you want an invite code and get an early access,',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Nunito'),
        // style: Theme.of(context).textTheme.headline2,
      )
    );
    final textField4 = FittedBox(
      fit: BoxFit.contain,
      child: RichText(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: 'please fill out ',
          style: TextStyle(
              fontSize: 16, fontFamily: 'Nunito'),
          children: <TextSpan>[
            TextSpan(text: 'this form',
                style: TextStyle(
                    color: Colors.white, fontSize: 16, decoration: TextDecoration.underline, fontFamily: 'Nunito'),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO: navigate to desired screen
                  }
            )
          ]
        ),
      )
    );

    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  textField1,
                  SizedBox(height: 80.0),
                  inviteCodeField,
                  SizedBox(height: 80.0),
                  continueButon,
                  SizedBox(height: 160.0),
                  textField2,
                  SizedBox(height: 45.0),
                  textField3,
                  SizedBox(height: 15.0),
                  textField4,
                ],
              ),
          ),
        ),
      ),
    );
  }
}