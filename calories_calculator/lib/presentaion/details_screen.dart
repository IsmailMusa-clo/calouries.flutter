import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:calories_calculator/cubit/cubit.dart';
import 'package:calories_calculator/cubit/state.dart';
import 'package:calories_calculator/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();

  late CaloriesatorLayoutCubit cubit;
  @override
  void initState() {
    cubit = CaloriesatorLayoutCubit.get(context);
    cubit.getBurnCalories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaloriesatorLayoutCubit, CaloriesatorLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedCircularChart(
                      key: _chartKey,
                      size: Size(300.0, 300.0),
                      initialChartData: <CircularStackEntry>[
                        CircularStackEntry(
                          <CircularSegmentEntry>[
                            CircularSegmentEntry(
                              55.0,
                              // cubit.proteinNeed!*100/(cubit.proteinNeed!+cubit.crabsNeed!+cubit.fatNeed!)
                              ColorManager.carbsColor,
                              rankKey: 'crabs',
                            ),
                            CircularSegmentEntry(
                              20.0,
                              ColorManager.proteinColor,
                              rankKey: 'Protein',
                            ),
                            CircularSegmentEntry(
                              25.0,
                              ColorManager.fatColor,
                              rankKey: 'Fat',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                      chartType: CircularChartType.Radial,
                      percentageValues: true,
                      holeLabel:
                          'Calories \n ${cubit.burnCalories!.toStringAsFixed(2)} kcal',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    detailsGraph(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget detailsGraph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Your daily needs to reach week goal : \n (based on your info)',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(
          height: 5.0,
        ),
        keyChartWidget(
            title: 'Protein - ${cubit.proteinNeed!.toStringAsFixed(2)}g',
            color: ColorManager.proteinColor),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            keyChartWidget(
                title: 'Crabs - ${cubit.crabsNeed!.toStringAsFixed(2)}g',
                color: ColorManager.carbsColor),
            SizedBox(
              width: 10.0,
            ),
            Image.asset(
              'assets/brotin.png',
              height: 70.0,
              width: 70.0,
            )
          ],
        ),
        keyChartWidget(
            title: 'Fat - ${cubit.fatNeed}g', color: ColorManager.fatColor),
        SizedBox(
          height: 25.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/water.png',
              height: 50.0,
              width: 50.0,
            ),
            Text(
              'You need ${cubit.waterNeed!} cups of water a day',
              style: TextStyle(
                  color: ColorManager.primary, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget keyChartWidget({required Color color, required String title}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10.0,
            width: 10.0,
            color: color,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          )
        ],
      );
}
