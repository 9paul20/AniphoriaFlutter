import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:aniphoria/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:aniphoria/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'common/theme_helper.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key: key);

      @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  Color _secondaryColor = HexColor("#1F1F1F");
  Color _primaryColor = HexColor("#363637");
  Color _accentColor = HexColor("#FF1166");

  double _headerHeight = 250;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  String usu="";
  String pass="";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: _secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Text('Bienvenido', style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: _accentColor),),
                      Text('Inicia Sesión', style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 30.0),
                      Form(
                        key: scaffoldKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: ThemeHelper().textInputDecoration('Usuario', 'Ingrese Correo Electrónico'),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 30.0),
                              TextFormField(
                                controller: passController,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: ThemeHelper().textInputDecoration('Contraseña', 'Ingrese La Contraseña'),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text('Inicio'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
                                  ),
                                  onPressed: (){
                                    login();
                                  },
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Future<void>login() async{
    String contraMD5 = md5.convert(utf8.encode(passController.text)).toString();
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("http://26.52.243.159/aniphoria-merch_v2/api/login.json"),
          body: ({
            'correo': emailController.text,
            'contrasenia': contraMD5,
          }));
      if (response.statusCode==200) {
        var datos = jsonDecode(response.body);
        if(datos['status']==0){
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Credenciales Invalidas")));
        }if(datos['status']==1){
          int id = datos['cliente']['id'];
          String nombre = datos['cliente']['nombre'];
          String apaterno = datos['cliente']['apaterno'];
          String amaterno = datos['cliente']['amaterno'];
          String correo = datos['cliente']['correo'];
          String telefono = datos['cliente']['telefono'];
          String usuario = datos['cliente']['usuario'];
          bool verificado = datos['cliente']['verificado'];
          String compania = "AniPhoria";
          String direccion = datos['cliente']['direccion'][0]['direccion'];
          String nacimiento = datos['cliente']['fecha_nacimiento'];
          String registro = datos['cliente']['fecha_registro'];
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage(id,nombre,apaterno,amaterno,verificado,correo,contraMD5,telefono,usuario,compania,direccion,nacimiento,registro)));
        }
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Credenciales Invalidas")));
      }
    } else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Textos Invalidos")));
    }
  }
}