import 'package:admin/constants.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  final Function(int) requestChangeStackIndex;
  final int currentStackIndex;
  const SideMenu({
    Key? key, 
    required this.requestChangeStackIndex,
    required this.currentStackIndex
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewChildren = [
      DrawerHeader(
        child: Image.asset("assets/images/logo2.png"),
      )
    ];
    
    listViewChildren.addAll(
      screenList.asMap().keys.map((index){
        final screenData = screenList[index];
        return DrawerListTile(
          title: screenData.name,
          svgSrc: screenData.image,
          press: (){ 
            print("Stack index changed to $index");
            requestChangeStackIndex(index); 
          },
          selected: currentStackIndex == index
        );
      })
    );
    return Drawer(
      child: ListView(
        children: listViewChildren
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.selected
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    Color titleColor = selected ? accentColor : Colors.white54;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: titleColor,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
    );
  }
}
