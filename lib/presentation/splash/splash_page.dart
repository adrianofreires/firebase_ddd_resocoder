import 'package:auto_route/auto_route.dart';
import 'package:firebase_ddd_resocoder/application/auth/auth_bloc.dart';
import 'package:firebase_ddd_resocoder/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_ddd_resocoder/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) => context.pushRoute(const NotesOverviewRoute()),
          unauthenticated: (_) => context.pushRoute(const SignInRoute()),
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
