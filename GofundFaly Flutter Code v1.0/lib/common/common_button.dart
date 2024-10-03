// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'light_dark_mode.dart';


ColorNotifier notifier = ColorNotifier();


Widget CommonButton({String? txt1,String? txt2,required Color containcolore,context,required void Function() onPressed1}){
  return  Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: containcolore,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ButtonStyle(elevation: const WidgetStatePropertyAll(0),backgroundColor: MaterialStatePropertyAll(containcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))))),
        onPressed: onPressed1,
        child: Center(
          child: RichText(text: TextSpan(
              children: [
                TextSpan(text: txt1,style: const TextStyle(fontSize: 15,fontFamily: "SofiaRegular")),
                TextSpan(text: txt2,style: const TextStyle(fontSize: 15,fontFamily: "SofiaRegular")),
              ]
          )),
        ),
      )
  );
}



Widget CommonButtonsmallround({String? txt1,String? txt2,required Color containcolore,context,required void Function() onPressed1}){
  return  Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: containcolore,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(containcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))))),
        onPressed: onPressed1,
        child: Center(
          child: RichText(text: TextSpan(
              children: [
                TextSpan(text: txt1,style:  TextStyle(fontSize: 15,fontFamily: 'SofiaRegular')),
                TextSpan(text: txt2,style:  TextStyle(fontSize: 15,fontFamily: 'SofiaRegular')),
              ]
          )),
        ),
      )
  );
}



Widget CommonButtonwithboarder({String? txt1,String? txt2,required Color bordercolore,context,required void Function() onPressed1,Color? clore}){
  notifier = Provider.of<ColorNotifier>(context, listen: true);
  return  Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: OutlinedButton(
        style: ButtonStyle(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),side: MaterialStatePropertyAll(BorderSide(color: bordercolore))),
        onPressed: onPressed1,
        child: Center(
          child: RichText(text: TextSpan(
              children: [
                TextSpan(text: txt1,style:  TextStyle(fontSize: 15,color: notifier.textcolore,fontFamily: "SofiaRegular")),
                TextSpan(text: txt2,style:  TextStyle(fontSize: 15,color: clore,fontFamily: "SofiaRegular")),
              ]
          )),
        ),
      )
  );
}



Widget CommonTextfiled200({required String txt,TextEditingController? controller,required BuildContext context}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return TextField(
    controller: controller,
    style: TextStyle(color: notifier.textcolore),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.red)),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      hintText: txt,hintStyle:  const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
      focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: theamcolore)),
    ),
  );
}


Widget CommonTextfiled11({ TextEditingController? controller,  String? txt,required BuildContext context}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return  TextField(
    controller: controller,
    obscureText: true,
    style: TextStyle(color: notifier.textcolore),
    decoration:  InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: theamcolore)),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      hintText: txt,hintStyle: const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
    ),
  );
}




Widget CommonTextfiled10({ TextEditingController? controller,  String? txt,required BuildContext context,required String suffeximage}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return  TextField(
    controller: controller,
    style:  TextStyle(color: notifier.textcolore),
    decoration:  InputDecoration(
      focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: theamcolore)),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      labelText: txt,labelStyle: const TextStyle(color: Colors.grey,fontSize: 14),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(suffeximage,height: 10,color: notifier.textcolore),
      ),
    ),
  );
}


Widget CommonTextfiledreadonly({ TextEditingController? controller,  String? txt,required BuildContext context,required String suffeximage}){
  return  TextField(
    controller: controller,
    readOnly: true,
    style: const TextStyle(color: Colors.black),
    decoration:  InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: theamcolore)),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      hintText: txt,hintStyle: const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(suffeximage,height: 10,),
      ),
    ),
  );
}


Widget CommonTextfiled2({required String txt,TextEditingController? controller,required BuildContext context}){
  return TextField(
    controller: controller,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.red)),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      hintText: txt,hintStyle:  const TextStyle(color: Colors.grey,fontFamily: "SofiaProBold",fontSize: 14),
      focusedBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: theamcolore)),
    ),
  );
}








Widget CommonButtonwallete({required String img,String? txt1,String? txt2,required Color containcolore,context,required void Function() onPressed1}){
  return  Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: containcolore,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ButtonStyle(elevation: MaterialStatePropertyAll(0),backgroundColor: MaterialStatePropertyAll(containcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
        onPressed: onPressed1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(img),color: Colors.white,height: 20,width: 20,),
            const SizedBox(width: 8,),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('$txt1',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
            ),
          ],
        ),
      )
  );
}



Widget textfield({required String title, required String enterName,TextEditingController? controller, TextInputType? textInputType, String? validate,required BuildContext context}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,style: TextStyle(color: notifier.textcolore,fontSize: 15)),
      const SizedBox(height: 10),
      SizedBox(
        height: 50,
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          style: TextStyle(color: notifier.textcolore),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theamcolore),borderRadius: BorderRadius.circular(10)),
            hintText: enterName,
            hintStyle: TextStyle(color: notifier.textcolore,fontSize: 13),
          ),
        ),
      ),
      const SizedBox(height: 13),
    ],
  );
}



GestButton(
    {String? buttontext,
      Function()? onclick,
      double? Width,
      double? height,
      Color? buttoncolor,
      EdgeInsets? margin,
      TextStyle? style,
      Gradient? gradient}) {
  return GestureDetector(
    onTap: onclick,
    child: Container(
      height: height,
      width: Width,
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: buttoncolor,
        gradient: gradient,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              0.5,
              0.5,
            ),
            blurRadius: 1,
          ),
        ],
      ),
      child: Text(buttontext!, style: style),
    ),
  );
}





Widget NextButton({String? txt1,String? txt2,required Color containcolore,context,required void Function() onPressed1}){
  return  Expanded(child: Container(
    height: 50,
    decoration: BoxDecoration(
      color: theamcolore,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(theamcolore),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
        onPressed: onPressed1,
        child:  Center(child: Text('Next'.tr,style: TextStyle(color: Colors.white,fontFamily: "SofiaProBold",fontSize: 14),))),
  ));
}


Widget NextButtonNon({String? txt1,String? txt2,context,required void Function() onPressed1}){
  return  Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xffDEE1F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
          style: ButtonStyle(elevation: WidgetStatePropertyAll(0),backgroundColor: MaterialStatePropertyAll(Color(0xffDEE1F7)),shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))),
          onPressed: onPressed1,
          child: Center(child: Text('Next'.tr,style:  TextStyle(color: theamcolore,fontFamily: "SofiaProBold",fontSize: 14),))),
    ),
  );
}






class gradient {
  static Gradient btnGradient = LinearGradient(
    colors: [theamcolore, theamcolore],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xff5bd80e), Color.fromARGB(255, 100, 199, 64)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient lightGradient = LinearGradient(
    colors: [Color(0xffdaedfd), Color(0xffdaedfd)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient cancleGradient = LinearGradient(
    colors: [Color(0xffBA021C), Color(0xffE1495E)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient completeGradient = LinearGradient(
    colors: [Color(0xff008A21), Color(0xff07DF3A)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Color defoultColor = Color(0xffEC3636);
}



Color theamcolore = const Color(0xff0236FF);
Color cancelbutton = const Color(0xffFF0043);
Color greaycolore = const Color(0xffF6F6F6);
Color boardercolore = const Color(0xffF6F6F6);





