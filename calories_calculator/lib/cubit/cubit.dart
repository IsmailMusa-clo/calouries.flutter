import 'package:bloc/bloc.dart';
import 'package:calories_calculator/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloriesatorLayoutCubit extends Cubit<CaloriesatorLayoutState> {
  CaloriesatorLayoutCubit() : super(CaloriesatorLayoutInitialState());

  static CaloriesatorLayoutCubit get(context) => BlocProvider.of(context);

  bool isKGSelected = true;
  int userGender = 0;
  int? userAge;
  double? userHeight,userWeight;

  setUserData({
    required int age,
    required double height,
    required double weight,
  }){
    userAge = age;
    userHeight = height;
    userWeight = weight;
    emit(CaloriesatorUserSetDataState());
  }

  int? levelActivityKey;
  int? weekGoalKey;

  transferUserData(){
    userWeight = userWeight! * 0.032808399;
    userHeight = userHeight! * 2.2046226218;
  }

  double calculateManBurnCalories(){
    print('calculateManBurnCalories ${userHeight}:${userWeight}');
    return (userHeight!*6.25)+(userAge!*5)+(userWeight!*10)+5;
  }
  double calculateWomanBurnCalories(){
    return (userHeight!*6.25)+(userAge!*5)+(userWeight!*10)-161;
  }

  double? burnCalories;
  getBurnCalories(){
    if(userGender!=0){
      transferUserData();
      burnCalories = calculateWomanBurnCalories();
    }else{
      burnCalories = calculateManBurnCalories();
    }
    calculateAllowedCalories();
  }

  double? allowedCalories ;
  calculateAllowedCalories(){
    if(levelActivityKey! < 2){
      allowedCalories = 1.2 * burnCalories!;
    }else if(levelActivityKey! < 4){
      allowedCalories = 1.5 * burnCalories!;
    }else{
      allowedCalories = 1.9 * burnCalories!;
    }
    calculateproteinNeed();
    calculateCrabsNeed();
    calculateFat();
    calculateWaterNeed();
    emit(CalculateCaloriesState());
  } 

  double? proteinNeed;
  calculateproteinNeed(){
    proteinNeed = (allowedCalories! * 0.15)/4;
  }

  double? crabsNeed;
  calculateCrabsNeed(){
    crabsNeed = (allowedCalories!*0.55)/4;
  }
  
  double? fatNeed;
  calculateFat(){
    // fatNeed = allowedCalories! * 0.30;
    // if(levelActivityKey! < 1){
    //  fatNeed = fatNeed!/2;
    // }else if(levelActivityKey! < 2){
    //  fatNeed = fatNeed!/4;
    // }else if(levelActivityKey! < 3){
    //  fatNeed = fatNeed!/6;
    // }else{
    //   fatNeed = fatNeed!/8;
    // }
    fatNeed = (allowedCalories! * 0.30)/9;
  }

  int? waterNeed;

  calculateWaterNeed(){
    waterNeed = ((((userWeight!*2.2)*userAge!)/28.3)/8).toInt();
  }
}