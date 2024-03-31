import 'package:flutter_svg/svg.dart';

class AppIcon{
  String iconName;
  String iconPath;

  AppIcon(this.iconName,this.iconPath);
  void icon(String iconName){
    SvgPicture.asset("assets/icons/${iconName}.svg");
  }
}