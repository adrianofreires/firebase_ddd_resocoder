import 'package:another_flushbar/flushbar_helper.dart';
import 'package:firebase_ddd_resocoder/application/auth/auth_bloc.dart';
import 'package:firebase_ddd_resocoder/application/notes/note_actor/note_actor_bloc.dart';
import 'package:firebase_ddd_resocoder/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:firebase_ddd_resocoder/injection.dart';
import 'package:firebase_ddd_resocoder/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:firebase_ddd_resocoder/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:firebase_ddd_resocoder/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
            create: (context) => getIt<NoteActorBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                  unauthenticated: (_) =>
                      context.pushRoute(const SignInRoute()),
                  orElse: () {});
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                    duration: const Duration(seconds: 5),
                    message: state.noteFailure.map(
                      unexpected: (_) =>
                          'Unexpected error occured while deleting, please contact support',
                      insufficientPermission: (_) => 'Insufficient Permissions',
                      unableToUpdate: (_) => 'Impossible Error',
                    ),
                  ).show(context);
                },
                orElse: () {});
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            actions: [
              UncompletedSwitch(),
            ],
          ),
          body: const NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: Navigate to NoteFormPage
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
