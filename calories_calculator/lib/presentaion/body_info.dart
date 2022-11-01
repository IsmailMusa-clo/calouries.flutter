import 'package:calories_calculator/cubit/cubit.dart';
import 'package:calories_calculator/cubit/state.dart';
import 'package:calories_calculator/presentaion/goals_screen.dart';
import 'package:calories_calculator/shared/colors.dart';
import 'package:calories_calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyInformationScreen extends StatefulWidget {
  BodyInformationScreen();
  
  @override
  State<BodyInformationScreen> createState() => _BodyInformationScreenState();
}

class _BodyInformationScreenState extends State<BodyInformationScreen> {

  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  int male = 0;

  int female = 1;

  late CaloriesatorLayoutCubit cubit;
  @override
  void initState() {
    cubit = CaloriesatorLayoutCubit.get(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaloriesatorLayoutCubit,CaloriesatorLayoutState>(
      listener: (context,state){
        if(state is CaloriesatorUserSetDataState)
          push(context, GoalsScreen());
      },
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Body Information'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/calculater.png',
                    height: 150.0,
                    width: 150.0,
                     ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: defaultTextFormField(
                          controller: _ageController,
                          validate: (age) {
                            if(age==null||age.isEmpty){
                              return 'required';
                            }
                            return null;
                          },
                          hint: 'Age',
                          type: TextInputType.number),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: defaultTextFormField(
                          controller: _heightController,
                          validate: (height) {
                            if(height==null||height.isEmpty){
                              return 'required';
                            }
                            if(double.parse(height) < 90){
                              return 'Minimum supported height is 90 cm';
                            }
                            if(double.parse(height) > 245){
                              return 'Maximum supported height is 245 cm';
                            }
                            return null;
                          },
                          hint: 'Height(${cubit.isKGSelected?'cm':'ft'})',
                          type: TextInputType.number),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: defaultTextFormField(
                          controller: _weightController,
                          validate: (weight) {
                            if(weight==null||weight.isEmpty){
                              return 'required';
                            }
                            if(double.parse(weight) < 20){
                              return 'Minimum supported weight is 20 cm';
                            }
                            if(double.parse(weight) > 450){
                              return 'Maximum supported weight is 450 cm';
                            }
                            return null;
                          },
                          hint: 'Weight(${cubit.isKGSelected?'kg':'lbs'})',
                          type: TextInputType.number),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: choiceItem(
                            title : 'Male',
                            backgroundColor: cubit.userGender==male?Color(0xFFB4CFEC):Color(0xFFEBDDE2),
                            onTap: (){
                              setState(() {
                                cubit.userGender = male;
                              });
                            }
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: choiceItem(
                            title : 'Female',
                            backgroundColor: cubit.userGender==female?Color(0xFFE8ADAA):Color(0xFFEBDDE2),
                            onTap: (){
                              setState(() {
                                cubit.userGender = female;
                              });
                            }
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        defualtButton(
                          title: 'Next',
                          onPressed: () {
                            if(_key.currentState!.validate()){
                              cubit.setUserData(
                                age: int.parse(_ageController.text),
                                height: double.parse(_heightController.text),
                                weight: double.parse(_weightController.text),
                              );
                            }
                          }
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget genderChoiceWidget({
    required int  value ,
    required String  title ,
  }) {
    return Row(
      children: [
        Radio(
          groupValue: cubit.userGender,
          value: value,
          fillColor: MaterialStateProperty.all<Color>(value==female?Colors.purpleAccent:ColorManager.primary),
          onChanged: (valueChange) {
            setState(() {
              cubit.userGender = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }
}
