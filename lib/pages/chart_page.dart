import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GroupedBarChart extends StatefulWidget{
  GroupedBarChart(this.correo, this.contraMD5, {Key? key}) : super(key: key);

  final String correo, contraMD5;

  @override
  State<StatefulWidget> createState() {
    return _GroupedBarChart();
  }
}

class _GroupedBarChart extends State<GroupedBarChart> {
  late List<GDPData> gdpDatas = [GDPData('Año', 50, _primaryColor)];
  late TooltipBehavior _tooltipBehavior;
  Color _secondaryColor = HexColor("#1F1F1F");
  Color _primaryColor = HexColor("#363637");
  Color _accentColor = HexColor("#FF1166");

  final emailController = TextEditingController();
  final passController = TextEditingController();

  List<GDPData> getChartData() {
    _getGDPData();
    final List<GDPData> chartDatas = gdpDatas;
    return chartDatas;
  }

  Future<List<GDPData>> _getGDPData() async{
    var response = await http.post(Uri.parse("http://26.52.243.159/aniphoria-merch_v2/api/login.json"),
        body: ({
          'correo': emailController.text,
          'contrasenia': passController.text,
        }));

    var datos = jsonDecode(response.body);
    int c = 0;
    gdpDatas = [];
    for(int i = 0; i < datos['anios'].length; i++){
      String anio1 = datos['anios'][i]['anio'];
      int pedidos1 = int.parse(datos['anios'][i]['pedidos']);
      GDPData gdpData = GDPData(anio1, pedidos1, _primaryColor);
      gdpDatas.add(gdpData);
    }
    return gdpDatas;
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = widget.correo;
    passController.text = widget.contraMD5;
    return SafeArea(
        child: Scaffold(
          backgroundColor: _secondaryColor,
          body: SfCartesianChart(
            title: ChartTitle(text: 'Ventas del ultimo año',textStyle: TextStyle(color: _accentColor)),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              BarSeries<GDPData, String>(
                  name: '',
                  color: _accentColor,
                  dataSource: getChartData(),
                  xValueMapper: (GDPData gdp, _) => gdp.continent,
                  yValueMapper: (GDPData gdp, _) => gdp.gdp,
                  pointColorMapper: (GDPData gdp, _) => gdp.color,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      color: _accentColor,
                  ),
                  enableTooltip: true)
            ],
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
              labelStyle: TextStyle(color: _accentColor),
            ),
          ),
        ));
  }
}

class GDPData {
  GDPData(this.continent, this.gdp, this.color);
  final String continent;
  final int gdp;
  final Color color;
}

