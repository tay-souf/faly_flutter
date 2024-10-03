// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gofunds/common/common_button.dart';


class Page_List_description extends StatefulWidget {
  final String title;
  final String description;

  const Page_List_description({super.key, required this.title, required this.description});

  @override
  State<Page_List_description> createState() => _Page_List_descriptionState();
}

class _Page_List_descriptionState extends State<Page_List_description> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: notifier.textcolore,
        ),
        title: Text(widget.title,style:  TextStyle(color: notifier.textcolore,fontSize: 16,fontFamily: 'SofiaProBold')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlWidget(
                onLoadingBuilder: (context, element, loadingProgress) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child:  Center(child: CircularProgressIndicator(color: theamcolore)));
                },
                widget.description,
                textStyle: const TextStyle(color: Colors.black, fontSize: 17,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
