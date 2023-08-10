import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/indicators_widget.dart';
import 'package:flutter_application_1/widget/pie_chart_sections.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: 
      Column(
        children: [
          AspectRatio(
        aspectRatio: 1.2,
        child:
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  // touchCallback: (pieTouchResponse){
                  //   setState(() {
                  //     if(pieTouchResponse.touchInput is FlLongPressEnd || pieTouchResponse.touchInput is FlPanEnd){
                  //       touchedIndex = -1;
                  //     }
                  //     else{        
                  //       touchedIndex = pieTouchResponse.touchSectionIndex;
                  //     }
                  //   });
                  // }
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 5,
                centerSpaceRadius: 60,
                sections: getSections())
            ),
          )
      ),
      SizedBox(height: 40,),
      Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child:
          Padding(padding: const EdgeInsets.all(0),
          child: IndicatorsWidget(),), )
        ],
      )
        ],
      )
    );
  }
}