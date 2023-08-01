import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/registerPage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = false;


Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    var box = await Hive.openBox<User>('users');

    if (!box.containsKey(email)) {
      print('Email không tồn tại');
      box.close();
      return;
    }
    User user = box.get(email)!;

    if (user.password != password) {
      print('Mật khẩu không đúng');
    } else {
      print('Đăng nhập thành công');
    }
    box.close();
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

                Text("Đăng nhập để tiếp tục", style: TextStyle(
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
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập Email";
                    } if
                      (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                        return 'Email không hợp lệ';
                    }
                    ;
                  },
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
                SizedBox(height: 30,),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                Text('Quên mật khẩu?', style: TextStyle(color: Color(0xFFFC8D27), fontSize: 14,)),
                ]
                ),
                SizedBox(height: 30,),
                 InkWell(
                  onTap: (){
                    if(_formfield.currentState!.validate()){
                      print("success");
                      emailController.clear();
                      passwordController.clear();
                    }
                   },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text("Đăng nhập", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bạn chưa có tài khoản?", style:TextStyle(fontSize: 14),),
                    InkWell( 
                      child: 
                        Text("Tạo tài khoản", style: TextStyle(color: Color(0xFFFC8D27), fontSize: 14)),
                      onTap: () {
                        Get.offAll(RegisterPage(),
                          duration: Duration(milliseconds: 700), // Thời gian chuyển trang
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 60,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                Text('Hoặc đăng nhập với', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
                ]
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Icon(Icons.phone_android, size: 30,),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      child: Icon(Icons.facebook_sharp, size: 30,),
                    )
                  ],
                )
              ],
            )
          ),
          
        )
      ),
    );
  }
}
