import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_app/features/auth/presentation/pages/login_page.dart';
import 'package:notas_app/features/notes/presentation/pages/home_page.dart';
import 'package:notas_app/features/notes/presentation/pages/note_form_page.dart';
import 'package:notas_app/features/notes/presentation/pages/notes_list_page.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutes.notes:
        return MaterialPageRoute(builder: (context) => const NotesListPage());

      case AppRoutes.note_form:
        return MaterialPageRoute(
          builder: (_) => const NoteFormPage(isEditMode: false),
        );

      // case AppRoutes.termsAndConditions:
      //   return CupertinoPageRoute(
      //     builder: (_) => const TermsAndConditionsPage(),
      //   );

      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
  //crear la pagina 404
  CupertinoPageRoute(builder: (_) => const LoginPage());
}
