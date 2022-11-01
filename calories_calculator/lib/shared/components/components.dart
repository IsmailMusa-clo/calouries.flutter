import 'package:calories_calculator/shared/colors.dart';
import 'package:flutter/material.dart';


  void push (context,Widget page){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

void pushAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) => false,
);

Widget defaultTextFormField({
  TextEditingController? controller,
  TextInputType type = TextInputType.text,
  String? hint,
  bool isPassword = false,
  Widget? suffixIcon,
  Widget? prefixIcon,
  required String? Function(String?)? validate,
  void Function()? onTap,
  Function()? onPasPres,
  int? maxLines,
  bool showCursor = true,
  bool readOnly = false

}){
  return Container(
    //height: 50,
    decoration: const BoxDecoration(
        color: Color(0xFFEBDDE2) ,
        borderRadius: BorderRadius.all(Radius.circular(8))
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTap,
      showCursor: showCursor,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 15.0,
            fontStyle: FontStyle.italic,
            
        ),
        suffixIcon: suffixIcon!=null?
        IconButton(onPressed:onPasPres,icon: suffixIcon) :null,
        prefixIcon: prefixIcon!=null?
        IconButton(onPressed:onPasPres,icon: prefixIcon) :null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none
        ),
      ),
      validator: validate,
      maxLines: maxLines,

    ),
  );
}

Widget defualtButton({
  required String title,
  required void Function()? onPressed
}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const  EdgeInsets.all(15.0),
        child: MaterialButton(
          color: Color(0xFFB38481),
          child:  Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          onPressed: onPressed
          )
        ),
    ],
  );
}

  Widget choiceItem({
    required String title,
    Color? backgroundColor,
    void Function()? onTap
  }) {
    return InkWell(
      onTap:onTap,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 40,
        child: Text(title,style: TextStyle(color: Colors.brown,fontSize: 14.0,fontWeight: FontWeight.bold)),
      ),
    );
  }