import 'package:cafe_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {


  TextEditingController emailController = new TextEditingController();

  String email="";

  final _formkey= GlobalKey<FormState>();

resetPassword() async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
      "Password Reset has been sent to email!", 
      style: TextStyle(
        fontSize: 18),
      )));

  } on FirebaseAuthException catch(e){
  if(e.code=="user-not-found"){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text
    ("No account found", 
    style: TextStyle(
      fontSize: 18),
    )));
  }
}

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
      body: Container(child: Column(children: [
        SizedBox(height: 70,),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            "Password Recovery", 
            style: TextStyle(
              color: Colors.white),
            ),
          ),
          SizedBox(height: 5,),
          Text("Enter your email", style:TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
          ),),

          Expanded(
            child: Form(
              key: _formkey,
              child: Padding(padding: EdgeInsets.only(left: 10),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter email';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: 
                    TextStyle(fontSize: 18, color: Colors.white),
                    prefixIcon: Icon(Icons.person, color: Colors.white70, size: 30, ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 40,),
              
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= emailController.text;
                      
                          });
                          resetPassword();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: 140,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Send Email", 
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 18, 
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont have an account?", style: TextStyle(fontSize: 18, color: Colors.white),),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                          },
                          child: Text("Create", style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20, fontWeight: FontWeight.w500
                          ),),
                        )
                      ],
                    )

                  ],
                ),
              )
        )
      )
      ],
      ),
    ),
    );
  }
}