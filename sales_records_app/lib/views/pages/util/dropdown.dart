import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sales_records_app/views/pages/home/chart_page.dart';
import 'package:sales_records_app/views/shared/shared.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({Key? key, required this.iconColor}) : super(key: key);
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.list,
          // size: 46,
          color: iconColor,
        ),
        customItemsHeights: [
          ...List<double>.filled(MenuItems.firstItems.length, 48),
          8,
          ...List<double>.filled(MenuItems.secondItems.length, 48),
        ],
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(
              enabled: false,
              child: Divider(
                color: Colors.white,
              )),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: primaryColor,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [chart];
  static const List<MenuItem> secondItems = [logout];

  static const chart = MenuItem(text: 'Chart', icon: Icons.stacked_line_chart);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) async {
    switch (item) {
      case MenuItems.chart:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chart(),
          ),
        );
        break;
      case MenuItems.logout:
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Confirm !',
          desc: 'Are you sure to Logout ?',
          buttonsTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: true,
          btnOk: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white),
            ),
          ),
          btnCancel: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "No",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ).show();
        break;
    }
  }
}
