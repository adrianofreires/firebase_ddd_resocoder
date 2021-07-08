import 'package:firebase_ddd_resocoder/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:firebase_ddd_resocoder/presentation/notes/notes_overview/widgets/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_note_card_widget.dart';

class NotesOverviewBody extends StatelessWidget {
  const NotesOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
        builder: (context, state) {
      return state.map(
        initial: (_) => Container(),
        loadInProgress: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        loadSuccess: (state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final note = state.notes[index];
              if (note.failureOption.isSome()) {
                return ErrorNoteCard(
                  note: note,
                );
              } else {
                return NoteCard(note: note);
              }
            },
            itemCount: state.notes.size,
          );
        },
        loadFailure: (state) {
          return Container(
            color: Colors.yellow,
            width: 200,
            height: 200,
          );
        },
      );
    });
  }
}
