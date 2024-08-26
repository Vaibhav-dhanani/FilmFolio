import 'package:filmfolio/utils/colors.dart';
import 'package:flutter/cupertino.dart';

class CustomCardThumbnail extends StatelessWidget {
  String images;
  CustomCardThumbnail({super.key,required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: kButtonColor.withOpacity(0.25),
          blurRadius:5,
          spreadRadius:1,
          offset: const Offset(0, 3))
        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(images),fit:BoxFit.cover),

      ),
      margin: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 30),
    );
  }

}
