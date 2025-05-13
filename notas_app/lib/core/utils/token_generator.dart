import 'dart:math';

/// Clase [TokenGenerator] para generar tokens aleatorios.
///
/// Esta clase proporciona un método estático para generar un token aleatorio
/// de una longitud especificada utilizando caracteres alfanuméricos.
class TokenGenerator {
  /// Genera un token aleatorio de longitud especificada.
  ///
  /// El token generado estará compuesto por caracteres alfanuméricos
  /// (mayúsculas, minúsculas y dígitos). Utiliza una fuente de aleatoriedad
  /// segura para garantizar que el token sea impredecible.
  ///
  /// Parámetros:
  /// - [length]: la longitud del token que se desea generar.
  ///
  /// Retorna:
  /// - Un [String] que representa el token aleatorio generado. con el .join
  static String generateToken(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
