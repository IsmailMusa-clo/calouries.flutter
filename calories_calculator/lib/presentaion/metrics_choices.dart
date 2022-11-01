import 'package:calories_calculator/cubit/cubit.dart';
import 'package:calories_calculator/cubit/state.dart';
import 'package:calories_calculator/presentaion/body_info.dart';
import 'package:calories_calculator/shared/colors.dart';
import 'package:calories_calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetricsChoicesScreen extends StatefulWidget {

  @override
  State<MetricsChoicesScreen> createState() => _MetricsChoicesScreenState();
}

class _MetricsChoicesScreenState extends State<MetricsChoicesScreen> {

  late CaloriesatorLayoutCubit cubit;
  @override
  void initState() {
    cubit = CaloriesatorLayoutCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaloriesatorLayoutCubit,CaloriesatorLayoutState>(
      listener: (context,state){},
      builder: (context,state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Metrices Choices'),
            ),
            body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Text(
                      'What metrices do you use ?',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ 
                        choiceItem(
                          title : 'KG/CM',
                          backgroundColor: cubit.isKGSelected?
                          Color(0xFFE8ADAA):
                          Color(0xFFEBDDE2),
                          onTap: changeMetriceSelect
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        choiceItem(
                          title : 'LBS/FT',
                          backgroundColor: !cubit.isKGSelected?
                          Color(0xFFE8ADAA):Color(0xFFEBDDE2),
                          onTap: changeMetriceSelect
                        ),
                      ],
                    ),
                    const Spacer(),
                    defualtButton(
                      title: 'Next',
                       onPressed: () => push(context,BodyInformationScreen())
                    )
                  ],
                )
             );
      }
    );
  }




  changeMetriceSelect(){
   setState(() {
      cubit.isKGSelected = !cubit.isKGSelected;
   });
  }
}
