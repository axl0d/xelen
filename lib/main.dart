import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/home_page.dart';

void main() async {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xelen',
      theme: ThemeData(
        colorScheme: customColorScheme,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

final ColorScheme customColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF78A0AB),
  onPrimary: Colors.black,
  primaryContainer: Color(0xFF78A0AB),
  onPrimaryContainer: Colors.black,
  secondary: Color(0xFF78A0AB),
  onSecondary: Colors.black,
  secondaryContainer: Color(0xFFAFEEEE),
  onSecondaryContainer: Colors.black,
  tertiary: Color(0xFF4B4B4B),
  onTertiary: Colors.white,
  tertiaryContainer: Color(0xFF6B6B6B),
  onTertiaryContainer: Colors.white,
  surface: Color(0xFFF0F8FF),
  onSurface: Colors.black,
  surfaceContainerHighest: Color(0xFFC0C0C0),
  onSurfaceVariant: Colors.black,
  error: Color(0xFFB00020),
  onError: Colors.white,
  errorContainer: Color(0xFFFFDAD4),
  onErrorContainer: Color(0xFF410002),
  outline: Color(0xFF7A7A7A),
  outlineVariant: Color(0xFFA5A5A5),
  shadow: Colors.black38,
  scrim: Colors.black54,
  inverseSurface: Color(0xFF303030),
  onInverseSurface: Colors.white,
  inversePrimary: Color(0xFF78A0AB),
);
