import 'package:flutter/material.dart';

class AppColors {
  /* <----------- Colors ------------> */
  /// Primary Color of this App
  static const Color primary = Color.fromARGB(255, 2, 139, 64);

  // Others Color
  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  /// used for page with box background
  static const Color scaffoldWithBoxBackground = Color(0xFFF7F7F7);
  static const Color cardColor = Color(0xFFF2F2F2);
  static const Color coloredBackground = Color(0xFFE4F8EA);
  static const Color placeholder = Color(0xFF8B8B97);
  static const Color textInputBackground = Color(0xFFF7F7F7);
  static const Color separator = Color(0xFFFAFAFA);
  //static const Color gray = Color(0xFFE1E1E1);

  /** <-------- Colors for this App -----> */
  // Texto
  static const Color textPrimary = Color(0xFF212121); // Texto principal
  static const Color textSecondary = Color(0xFF9E9E9E); // Texto secundario
  static const Color textOnPrimary = Color(
    0xFFFFFFFF,
  ); // Texto sobre fondos naranjas u oscuros

  // Fondos
  static const Color backgroundMain = Color(0xFFF5F5F5); // Fondo general
  static const Color backgroundAlt = Color(
    0xFFFFFFFF,
  ); // Fondo de tarjetas, pantallas internas

  // Botones
  static const Color buttonPrimary = Color.fromARGB(
    255,
    2,
    139,
    64,
  ); // Naranja principal
  static const Color buttonSecondary = Color(0xFFFFCC80); // Naranja claro
  static const Color buttonPressed = Color(0xFFE65100); // Naranja oscuro

  // Estados
  static const Color success = Color(0xFF43A047); // Éxito
  static const Color error = Color(0xFFE53935); // Error o alerta

  // Extras
  static const Color border = Color(0xFF9E9E9E); // Bordes de inputs o tarjetas
  static const Color shadow = Color(0xFF263238); // Para sombras o profundidad

  //card
  static const Color backgroundCard = Color(0xFFF5F5F5);
}
