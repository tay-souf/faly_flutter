import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../common/common_button.dart';
import '../common/light_dark_mode.dart';
import 'add_fundraiser_photo_screen.dart';


TextEditingController patentnamecontroller = TextEditingController();
TextEditingController fundplancontroller = TextEditingController();
TextEditingController patientdiagnosiscontroller = TextEditingController();
List<String> passengerimage=[];

var selectedDateAndTime = DateTime.now();
List<String> image=[];
var sender;


const List<String> list = <String>['Publish', 'Unpublish',];

class Passenger_Details extends StatefulWidget {
  const Passenger_Details({super.key});

  @override
  State<Passenger_Details> createState() => _Passenger_DetailsState();
}

class _Passenger_DetailsState extends State<Passenger_Details> {



  ImagePicker picker = ImagePicker();
  ImagePicker picker1 = ImagePicker();



  // certifect code

  Future camera() async {
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        image.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }
  Future gallery() async {
    XFile? file = await picker1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        image.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }


  // passenger code

  ImagePicker passengerpicker = ImagePicker();
  ImagePicker passengerpicker1 = ImagePicker();

  Future passengercamera() async {
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if(file!=null){
      setState(() {
        passengerimage.add(file.path);
      });
    } else{
      Fluttertoast.showToast(msg: 'image pick in not Camera!!'.tr);
    }
  }
  Future passengergallery() async {
    XFile? file = await picker1.pickImage(source: ImageSource.gallery);
    if(file!=null){
      setState(() {
        passengerimage.add(file.path);
      });
    }else{
      Fluttertoast.showToast(msg: 'image not selected!!'.tr);
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  String dropdownValue = list.first;

  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return  Scaffold(
      backgroundColor: notifier.background,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: notifier.background,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (sender == "Publish" || sender == "Unpublish") ?

                      (patentnamecontroller.text.isNotEmpty && fundplancontroller.text.isNotEmpty && patientdiagnosiscontroller.text.isNotEmpty && passengerimage.isNotEmpty && image.isNotEmpty && list.isNotEmpty) ?
                        NextButton(containcolore: theamcolore, onPressed1: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Fundraiser_photo(),));
                        },) :
                      NextButtonNon(onPressed1: () {},)
                          :
                      NextButtonNon(onPressed1: () {
                        print("${sender}");
                      },)


                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: notifier.containercolore,
                  child:  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40,),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(Icons.arrow_back,color: notifier.textcolore,size: 20)),
                            const Spacer(),
                            Text('Fund Details'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 18)),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Text('Enter Fund'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                        const SizedBox(height: 5,),
                        Text('Details'.tr,style: TextStyle(color: notifier.textcolore,fontFamily: "SofiaProBold",fontSize: 22),),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: Get.height * 0.78,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: notifier.background,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                    ),
                    child:  SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Step 3 of 4'.tr,style: const TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "SofiaProBold"),),
                            const SizedBox(height: 10,),
                             Text('Recipient Name'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: patentnamecontroller,
                              style: TextStyle(color: notifier.textcolore),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 0.1),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10 ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.pink)),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                    BorderSide(color: theamcolore)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color:  Colors.grey.withOpacity(0.4))),
                                hintText: 'Beneficiary Name'.tr,
                                hintStyle: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 15,),
                             Text('Fund Plan'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: fundplancontroller,
                              style: TextStyle(color: notifier.textcolore),
                              maxLines: 3,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 0.1),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10 ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.pink)),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                    BorderSide(color: theamcolore)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color:  Colors.grey.withOpacity(0.4))),
                                hintText: 'How Your Donations Will Be Used'.tr,
                                hintStyle: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 15,),
                             Text('Medical Condition'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: patientdiagnosiscontroller,
                              style: TextStyle(color: notifier.textcolore),
                              maxLines: 3,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 0.1),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10 ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.pink)),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                    BorderSide(color: theamcolore)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color:  Colors.grey.withOpacity(0.4))),
                                hintText: 'Health Condition and Diagnosis'.tr,
                                hintStyle: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Text('Select Beneficiary Pictures'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: notifier.containercolore,
                                  isDismissible: false,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                    onPressed: ()  {
                                                      passengergallery();
                                                      Get.back();
                                                    },
                                                    child:  Text("Gallery".tr, style: TextStyle( fontSize: 15, color: notifier.textcolore),),
                                                  ),
                                                ),
                                                SizedBox(width: 13),
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                    onPressed: ()  {
                                                      passengercamera();
                                                      Get.back();
                                                    },
                                                    child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 190,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: theamcolore),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            passengerimage.isEmpty ? const SizedBox() : SizedBox(
                              height:  170,
                              child: ListView.builder(
                                clipBehavior: Clip.none,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(bottom: 10),
                                itemCount: passengerimage.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 300,
                                        width: 150,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(image: FileImage(File(passengerimage[index])),fit: BoxFit.cover)
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: -8,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passengerimage.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            height: 26,
                                            width: 26,
                                            decoration: BoxDecoration(
                                              color: theamcolore,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },),
                            ),
                            const SizedBox(height: 10,),
                            Text('Select Fund Expiration Date'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () => selectDateAndTime(context),
                              child: Container(
                                height: 45,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(selectedDateAndTime.toString().split(" ").first,style: TextStyle(color: notifier.textcolore),),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: () => selectDateAndTime(context),
                                          child: Icon(Icons.calendar_month,size: 26,color: theamcolore),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                             Text('Upload Medical Certificate or Other Documentation'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: notifier.containercolore,
                                  isDismissible: false,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(13))),
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: notifier.textcolore),),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                    onPressed: ()  {
                                                      gallery();
                                                      Get.back();
                                                    },
                                                    child:  Text("Gallery".tr, style: TextStyle( fontSize: 15, color: notifier.textcolore),),
                                                  ),
                                                ),
                                                SizedBox(width: 13),
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: OutlinedButton.styleFrom(side: BorderSide(color: notifier.textcolore),fixedSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                                    onPressed: ()  {
                                                      camera();
                                                      Get.back();
                                                    },
                                                    child:  Text("Camera".tr, style: TextStyle(fontSize: 15, color: notifier.textcolore),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 190,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: theamcolore),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:  Center(child: Text('Upload Photos (Multiple)'.tr,style: TextStyle(color: notifier.textcolore),)),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            image.isEmpty ? const SizedBox() : SizedBox(
                              height:  170,
                              child: ListView.builder(
                                clipBehavior: Clip.none,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(bottom: 10),
                                itemCount: image.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 300,
                                        width: 150,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(image: FileImage(File(image[index])),fit: BoxFit.cover)
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: -8,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              image.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            height: 26,
                                            width: 26,
                                            decoration: BoxDecoration(
                                              color: theamcolore,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(child: Icon(Icons.close, color: Colors.white, size: 18,)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },),
                            ),
                            const SizedBox(height: 10,),
                            Text('Select Status'.tr,style: TextStyle(color: notifier.textcolore,fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            DropdownButtonFormField(
                              validator: (value) {
                                if(value == null){
                                  return 'Choose your Customer'.tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                // hintText: 'Select Status'.tr,
                                contentPadding: const EdgeInsets.all(12),
                                hintStyle:  TextStyle(fontSize: 14,color: notifier.textcolore),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theamcolore),borderRadius: BorderRadius.circular(10)),
                              ),
                              dropdownColor: notifier.containercolore,
                              hint: Text("Select Status".tr,style: TextStyle(fontSize: 14,color: notifier.textcolore)),
                              onChanged: (newValue) {
                                setState(() {
                                  sender = newValue;
                                  print('ghutyg -->  ${sender == "Publish"  ? '0' : '1'}');
                                  print(' + + + + $newValue');
                                });
                              },
                              value: sender,
                              items: list.map<DropdownMenuItem>((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item,style: TextStyle(color: notifier.textcolore)),
                                );

                              }).toList(),
                            ),
                            const SizedBox(height: 100,),
                          ],
                        ),
                      ),
                    ),

                ),
              ],
            )
          ],
        ),
      ),
    );
  }







  Future<void> selectDateAndTime(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateAndTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:  ColorScheme.light(
              primary: theamcolore,
              onPrimary: Colors.white,
              onSurface: theamcolore,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                // primary: Colors.black,
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    print(pickedDate);
    if (pickedDate != null && pickedDate != selectedDateAndTime) {
      setState(() {
        selectedDateAndTime = pickedDate;
      });
    }
  }


}
