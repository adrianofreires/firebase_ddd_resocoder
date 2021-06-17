import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_resocoder/domain/notes/i_note_repository.dart';
import 'package:firebase_ddd_resocoder/domain/notes/note.dart';
import 'package:firebase_ddd_resocoder/domain/notes/note_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;

  NoteWatcherBloc(this._noteRepository) : super(const _Initial());

  late StreamSubscription<Either<NoteFailure, KtList<Note>>>
      _notesStreamSubscription;

  @override
  Stream<NoteWatcherState> mapEventToState(
    NoteWatcherEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _notesStreamSubscription?.cancel();
        _notesStreamSubscription = _noteRepository.watchAll().listen(
            (failureOrNotes) =>
                add(NoteWatcherEvent.notesReceived(failureOrNotes)));
      },
      watchUncompletedStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _notesStreamSubscription?.cancel();
        _notesStreamSubscription = _noteRepository.watchUncompleted().listen(
            (failureOrNotes) =>
                add(NoteWatcherEvent.notesReceived(failureOrNotes)));
      },
      notesReceived: (e) async* {
        yield e.failureOrNotes.fold(
          (f) => NoteWatcherState.loadFailure(f),
          (notes) => NoteWatcherState.loadSuccess(notes),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _notesStreamSubscription?.cancel();
    return super.close();
  }
}
