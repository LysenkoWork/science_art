import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:science_art/model/candidate_model.dart';
import 'package:science_art/pages/candidates/bloc/candidate_event.dart';
import 'package:science_art/pages/candidates/bloc/candidate_state.dart';
import 'package:science_art/pages/candidates/services/candidate_repository.dart';

class CandidateBloc extends Bloc<CandidateEvent, CandidateState> {
  final CandidateRepository candidateRepository;

  CandidateBloc({
    required this.candidateRepository,
  }) : super(CandidateEmptyState()) {
    on<CandidateLoadEvent>((event, emit) async {
      emit(CandidateLoadingState());
      try {
        final List<Candidate> loadedCandidateList =
            await candidateRepository.getAllCandidates();
        emit (CandidateLoadedState(loadedCandidates: loadedCandidateList));
      } catch (_) {
        emit(CandidateErrorState());
      }
    });
  }

  @override
  void onChange(Change<CandidateState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  @override
  void onTransition(Transition<CandidateEvent, CandidateState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
  }

  @override
  void onEvent(CandidateEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
