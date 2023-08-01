import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/loginPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  bool passToggle = false;
  bool rePassToggle = false;
  final _usersBox = Hive.box('users');
  bool userExists = false;

  void createUser(){
    print('vào create');
    User newUser = User(email: emailController.text, password: passwordController.text);
    bool checkExist = _usersBox.values.any((user) => user['email'] == emailController.text);
    setState(() {
          userExists = checkExist;
    });
    if (checkExist) {
        print('đã tồn tại email');
        return;
    }
    _usersBox.add(newUser.toMap());
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    Get.offAll(LoginPage(),duration: Duration(milliseconds: 1500),);
  }

  String? validateEmail(String? value, bool userExists) {
  if (value == null || value.isEmpty) {
    return "Vui lòng nhập Email";
  }
  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
    return 'Email không hợp lệ';
  }
  if (userExists) {
    return 'Email đã tồn tại';
  }
  return null;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),

                Text("Tạo tài khoản mới", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) => validateEmail(value, userExists),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: !passToggle,
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: (){
                        setState(() {
                        passToggle = !passToggle;
                        });
                      },
                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off,)
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Vui lòng nhập mật khẩu";
                  }
                  else if(passwordController.text.length < 6 ){
                    return "Nhập mật khẩu dài hơn 6 ký tự";
                  }
                },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: rePasswordController,
                  obscureText: !rePassToggle,
                  decoration: InputDecoration(
                    labelText: "Xác nhận lại mật khẩu",
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: (){
                        setState(() {
                        rePassToggle = !rePassToggle;
                        });
                      },
                      child: Icon(rePassToggle ? Icons.visibility : Icons.visibility_off,)
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Vui lòng nhập mật khẩu";
                  }
                  else if(passwordController.text.length < 6 ){
                    return "Nhập mật khẩu dài hơn 6 ký tự";
                  }else if(passwordController.text != rePasswordController.text){
                    return "Mật khẩu không trùng khớp";
                  }
                },
                ),
               
                SizedBox(height: 40,),
                 InkWell(
                  onTap: (){
                    if(_formfield.currentState!.validate()){
                      createUser();
                    }
                   },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text("Tạo tài khoản", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bạn đã có tài khoản? ", style:TextStyle(fontSize: 14),),
                    InkWell(
                      child:
                        Text("Đăng nhập", style: TextStyle(color: Color(0xFFFC8D27), fontSize: 14)),
                      onTap: () {
                        Get.offAll(LoginPage(),duration: Duration(milliseconds: 700),);
                      },
                    )
                  ],
                ),
              ],
            )
          ),
          
        )
      ),
    );
  }
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
