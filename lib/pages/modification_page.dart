import 'dart:async';
import 'package:aniphoria/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'common/theme_helper.dart';
import 'profile_page.dart';

class ModificationPage extends  StatefulWidget{
  ModificationPage(this.id, this.nombre, this.apaterno, this.amaterno, this.usuario, this.correo, this.contraMD5,this.nacimiento, this.direccion,this.telefono, this.registro, this.verificado,{ Key? key}) : super(key: key);

  final int id;
  final bool verificado;
  final String nombre,apaterno,amaterno,correo,contraMD5,telefono,usuario,direccion,nacimiento,registro;

  @override
  State<StatefulWidget> createState() {
    return _ModificationPageState();
  }
}

class _ModificationPageState extends State<ModificationPage>{

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  Color _secondaryColor = HexColor("#1F1F1F");

  final nameController = TextEditingController();
  final apController = TextEditingController();
  final amController = TextEditingController();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final dateController = TextEditingController();
  final addressController = TextEditingController();
  final telephoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.nombre;
    apController.text = widget.apaterno;
    amController.text = widget.amaterno;
    userController.text = widget.usuario;
    emailController.text = widget.correo;
    passController.text = widget.contraMD5;
    dateController.text = widget.nacimiento;
    addressController.text = widget.direccion;
    telephoneController.text = widget.telefono;
    return Scaffold(
      backgroundColor: _secondaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          child: TextFormField(
                            controller: nameController,
                            decoration: ThemeHelper().textInputDecoration('Nombre(s)', 'Ingrese nombre(s)'),
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if(!(val!.isEmpty)){
                                return "Ingrese nombre(s) valido(s)";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: TextFormField(
                            controller: apController,
                            decoration: ThemeHelper().textInputDecoration('Apellido Paterno', 'Ingrese Apellido Paterno'),
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if(!(val!.isEmpty)){
                                return "Ingrese apellido valido";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: TextFormField(
                            controller: amController,
                            decoration: ThemeHelper().textInputDecoration('Apellido Materno', 'Ingrese Apellido Materno'),
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if(!(val!.isEmpty)){
                                return "Ingrese apellido valido";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: userController,
                            decoration: ThemeHelper().textInputDecoration('Usuario', 'Ingrese usuario'),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if(!(val!.isEmpty)){
                                return "Ingrese usuario valida";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper().textInputDecoration("Correo", "Ingrese Correo"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Ingrese un correo valido";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: dateController,
                            decoration: ThemeHelper().textInputDecoration('Fecha Nacimiento', 'Ingrese Fecha Nacimiento'),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if(!(val!.isEmpty)){
                                return "Ingrese fecha valida";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: telephoneController,
                            decoration: ThemeHelper().textInputDecoration(
                                "Telefono",
                                "Ingrese Telefono"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Ingrese Numero Valido";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Actualizar".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              update();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void>update() async{
    int ide = widget.id;
    if (nameController.text.isNotEmpty && apController.text.isNotEmpty && amController.text.isNotEmpty && userController.text.isNotEmpty && emailController.text.isNotEmpty && telephoneController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("http://26.52.243.159/aniphoria-merch_v2/api/edit/$ide.json"),
          body: ({
            'nombre': nameController.text,
            'apaterno': apController.text,
            'amaterno': amController.text,
            'usuario': userController.text,
            'correo': emailController.text,
            'fecha_nacimiento': dateController.text,
            'telefono': telephoneController.text,
          }));
      if (response.statusCode==200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Actualización Correcta")));
        int id = ide;
        String nombre = nameController.text;
        String apaterno = apController.text;
        String amaterno = amController.text;
        String correo = emailController.text;
        String contraMD5 = passController.text;
        String telefono = telephoneController.text;
        String usuario = userController.text;
        String nacimiento = dateController.text;
        String compania = "AniPhoria";
        String direccion = addressController.text;
        String registro = widget.registro;
        bool verificado = widget.verificado;
        Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage(id,nombre,apaterno,amaterno,verificado,correo,contraMD5,telefono,usuario,compania,direccion,nacimiento,registro)));

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