part of 'shared.dart';

double defaultMargin = 24;

Color primaryColor = const Color(0xFF285430);
Color secondaryColor = const Color(0xFF5F8D4E);
Color tertiaryColor = const Color(0xFFA4BE7B);
Color containerColor = const Color(0xFF557153);
Color blackColor = Colors.black;
Color green200 = const Color(0xFFD6FFDE);
Color green300 = const Color(0xFF80EB93);
Color green400 = const Color(0xFF4FD15A);
Color green500 = const Color(0xFF03AC0E);

TextStyle primaryTextStyle = GoogleFonts.roboto(
  fontSize: 36,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);
TextStyle secondaryTextStyle = GoogleFonts.roboto(
  fontSize: 36,
  color: secondaryColor,
  fontWeight: FontWeight.w500,
);
TextStyle blackTextStyle = GoogleFonts.poppins(
  fontSize: 36,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

class ColorPalette {
  static const MaterialColor greenColor =
      MaterialColor(0xFF5F8D4E, <int, Color>{
    50: Color(0xFF5F8D4E),
    100: Color(0xFF5F8D4E),
    200: Color(0xFF5F8D4E),
    300: Color(0xFF5F8D4E),
    400: Color(0xFF5F8D4E),
    500: Color(0xFF5F8D4E),
    600: Color(0xFF5F8D4E),
    700: Color(0xFF5F8D4E),
    800: Color(0xFF5F8D4E),
    900: Color(0xFF5F8D4E),
  });
}
