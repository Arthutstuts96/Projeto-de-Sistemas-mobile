import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PerformancePieChart extends StatefulWidget {
  const PerformancePieChart({super.key});

  @override
  State<PerformancePieChart> createState() => _PerformancePieChartState();
}

class _PerformancePieChartState extends State<PerformancePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8, 
      child: Row(
        spacing: 2,
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 2, 
                centerSpaceRadius:
                    40, 
                sections: showingSections(), // A lista de fatias
              ),
            ),
          ),
          // --- A Legenda ---
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: <Widget>[
              Indicator(
                color: Color(0xff0293ee),
                text: 'Entregas no Prazo',
                isSquare: true,
              ),
              Indicator(
                color: Color(0xfff8b250),
                text: 'Pedidos Corretos',
                isSquare: true,
              ),
              Indicator(
                color: Color(0xff845bef),
                text: 'Avaliações Positivas',
                isSquare: true,
              ),
              Indicator(
                color: Color(0xff13d38e),
                text: 'Outros',
                isSquare: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Função que gera os dados para cada fatia do gráfico
  List<PieChartSectionData> showingSections() {
    // --- DADOS FICTÍCIOS - Altere aqui ---
    final Map<String, double> dataMap = {
      "Entregas no Prazo": 40,
      "Pedidos Corretos": 30,
      "Avaliações Positivas": 15,
      "Outros": 15,
    };

    final List<Color> colors = [
      const Color(0xff0293ee),
      const Color(0xfff8b250),
      const Color(0xff845bef),
      const Color(0xff13d38e),
    ];

    return List.generate(dataMap.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final title = '${dataMap.values.elementAt(i).toInt()}%';
      final color = colors[i];

      return PieChartSectionData(
        color: color,
        value: dataMap.values.elementAt(i),
        title: title,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [const Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
