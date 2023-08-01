import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/pie_data.dart';

class IndicatorsWidget extends StatelessWidget {
const IndicatorsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: PieData.data
      .map(
        (data) => Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: buildIndicator(color: data.color, text:data.name, percent :data.percent ),
      )).toList(),
    );
  }
  
  Widget buildIndicator({
    required Color color,
    required String text,
    required double percent,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
    }) =>
    Padding(padding: EdgeInsets.symmetric(horizontal: 10), 
    child: 
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        // SizedBox(width: 5,),
        Text(
          text,
          style: TextStyle(

            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor
          ),
        ),
        Text(
          '${percent}',
          style: TextStyle(

            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor
          ),
        )
      ],
    ),);
   
}