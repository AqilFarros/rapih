part of '../widget.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 10,
                ),
                BarChartRodData(
                  toY: 4,
                ),
              ],
            ),
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 10,
                ),
                BarChartRodData(
                  toY: 4,
                ),
              ],
            ),
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 10,
                ),
                BarChartRodData(
                  toY: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
