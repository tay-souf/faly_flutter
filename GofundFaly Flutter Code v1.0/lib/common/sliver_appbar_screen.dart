import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofunds/common/config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/getapi_controller.dart';
import 'common_button.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    FundDidWiseController fundDidWiseController = Get.put(FundDidWiseController());

    final controller = PageController();
    return Stack(
      children: [
        Container(
          width: Get.size.width,
          alignment: Alignment.center,
          child: PageView.builder(
            controller: controller,
            itemCount: fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.length,
            itemBuilder: (_, index1) {
              return Image.network("${Config.baseurl}${fundDidWiseController.fundidimodel!.funddata[0].fundPhotos[index1]}", fit: BoxFit.cover);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,color: theamcolore),
              ),
            ],
          ),
        ),
        fundDidWiseController.fundidimodel!.funddata[0].fundPhotos.length > 1 ?  Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: fundDidWiseController.fundidimodel!.funddata[0].patientPhoto.length,
              effect: WormEffect(
                activeDotColor: theamcolore,
                dotColor: Colors.white,
                dotHeight: 8,
                dotWidth: 8,
                type: WormType.thinUnderground,
              ),
            ),
          ),
        ) : SizedBox(),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}