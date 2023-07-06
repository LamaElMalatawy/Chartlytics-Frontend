import 'package:flutter/material.dart';
import 'package:pick_image/helper/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget{
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      inactiveThumbImage: const AssetImage('assets/images/sun.png'),
      activeThumbImage: const AssetImage('assets/images/moon.png'),
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);

      },
    );
  }
}

