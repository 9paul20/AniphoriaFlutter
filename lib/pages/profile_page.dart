import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'chart_page.dart';
import 'login_page.dart';
import 'modification_page.dart';
import 'splash_screen.dart';
import 'widgets/header_widget.dart';

class ProfilePage extends StatefulWidget{
  ProfilePage(this.id, this.nombre, this.apaterno, this.amaterno, this.verificado, this.correo, this.contraMD5, this.telefono, this.usuario, this.compania, this.direccion, this.nacimiento, this.registro, { Key? key}) : super(key: key);

  final int id;
  final String nombre,apaterno,amaterno,correo,contraMD5,telefono,usuario,compania,direccion,nacimiento,registro;
  final bool verificado;

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  Color _secondaryColor = HexColor("#1F1F1F");
  Color _primaryColor = HexColor("#363637");
  Color _accentColor = HexColor("#FF1166");


  @override
  Widget build(BuildContext context) {
    String verificacion;
    if (widget.verificado==true) {
      verificacion = "Estoy verificado";
    }else{
      verificacion = "No estoy verificado";
    }
    return Scaffold(
      backgroundColor: _secondaryColor,
      appBar: AppBar(
        title: Text("Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("AniPhoria",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Login', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Graficas', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroupedBarChart(widget.correo, widget.contraMD5)));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Modificar Perfil', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ModificationPage(widget.id, widget.nombre, widget.apaterno, widget.amaterno, widget.usuario, widget.correo, widget.contraMD5, widget.nacimiento, widget.direccion, widget.telefono, widget.registro, widget.verificado)),);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ModificationPage(0, '', '', '', '', '', '', '', '')),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Salir de la App',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(widget.nombre+" "+widget.apaterno+" "+widget.amaterno, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,  color: _accentColor),),
                  SizedBox(height: 20,),
                  Text(widget.compania, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _accentColor),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Información",
                            style: TextStyle(
                              color: _accentColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Localidad"),
                                          subtitle: Text("Celaya, GTO, México "+widget.direccion),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Correo"),
                                          subtitle: Text(widget.correo),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Telefono"),
                                          subtitle: Text(widget.telefono),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text("Acerca de la cuenta"),
                                          subtitle: Text(
                                              "Soy "+ widget.usuario+"\n"+"Y "+ verificacion+"\nNací el "+widget.nacimiento+"\nMe Registré el "+widget.registro),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}