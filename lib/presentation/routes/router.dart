import 'package:auto_route/annotations.dart';
import 'package:firebase_ddd_resocoder/presentation/notes/note_form/note_form_page.dart';
import 'package:firebase_ddd_resocoder/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:firebase_ddd_resocoder/presentation/sign_in/sign_in_page.dart';
import 'package:firebase_ddd_resocoder/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: NotesOverviewPage),
    MaterialRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
)
class $Router {}
