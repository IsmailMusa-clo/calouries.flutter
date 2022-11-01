import 'package:calories_calculator/cubit/cubit.dart';
import 'package:calories_calculator/cubit/state.dart';
import 'package:calories_calculator/presentaion/details_screen.dart';
import 'package:calories_calculator/shared/colors.dart';
import 'package:calories_calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {

  late CaloriesatorLayoutCubit cubit;
  @override
  void initState() {
    cubit = CaloriesatorLayoutCubit.get(context);
    print('GoalsScreen ${cubit.userHeight}:${cubit.userWeight}');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaloriesatorLayoutCubit,CaloriesatorLayoutState>(
      listener: (context,state){

      },
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Goals'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _levelActivityDropDown(),
                  const SizedBox(height: 20.0,),
                  _weekActivityDropDown(),
                  const SizedBox(height: 10.0,),
                  Image.asset(
                      'assets/effort.png',
                    height: 200.0,
                    width: 200.0,
                     ),
                    SizedBox(height: 30.0,),
                  defualtButton(
                    title: 'Next',
                     onPressed: () {
                      if(cubit.levelActivityKey==null||cubit.weekGoalKey==null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("must you select goals"),
                        ));
                      }else{
                        push(context,DetailsScreen());
                      }
                     }
                  )  
                ],
              ),
            ),
          ),
        );
      }
    );
  }
 
  Widget _levelActivityDropDown() {
    return Container(
      width: 280.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<int>(
                  underline: Container(color: Colors.white),
                  hint: const Text('Level of activity'),
                  items: const [
                    DropdownMenuItem<int>(
                        value: 0, child: Text('Little or no exercise')),
                    DropdownMenuItem<int>(
                        value: 1, child: Text('Light exercise 1-3 days')),
                    DropdownMenuItem<int>(
                        value: 2, child: Text('Sports 3-5 days')),
                    DropdownMenuItem<int>(
                        value: 3, child: Text('Hard sport 6-7 days')),
                    DropdownMenuItem<int>(
                        value: 4,
                        child: Text('Intensive sports + physical job')),
                  ],
                  value: cubit.levelActivityKey,
                  iconEnabledColor: ColorManager.primary,
                  onChanged: (value) {
                   setState(() {
                     cubit.levelActivityKey = value;
                   });
                  },
                ),
          ),
        )
          
      ),
    );
  }

 
  Widget _weekActivityDropDown() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: 250.0,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                    underline: Container(color: Colors.white),
                    hint: const Text('Week goal'),
                    items: const [
                      DropdownMenuItem<int>(
                          value: 0, child: Text('Lose 1 kg')),
                      DropdownMenuItem<int>(
                          value: 1, child: Text('Lose 0.5 kg')),
                      DropdownMenuItem<int>(
                          value: 2, child: Text('Maintain current weight')),
                      DropdownMenuItem<int>(
                          value: 3, child: Text('Gain 0.5 kg')),
                      DropdownMenuItem<int>(
                          value: 4,
                          child: Text('Gain 1 kg')),
                    ],
                   // menuMaxHeight: 200.0,
                    value: cubit.weekGoalKey,
                    iconEnabledColor: ColorManager.primary,
                    onChanged: (value) {
                     setState(() {
                       cubit.weekGoalKey = value;
                     });
                    },
                  ),
            ),
          ),
        )
      ),
    );
  }
}
