import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:science_art/model/candidate_model.dart';
import 'package:science_art/pages/candidates/bloc/candidate_event.dart';
import 'package:science_art/pages/candidates/bloc/candidate_state.dart';
import 'package:science_art/pages/candidates/services/participant_repository.dart';

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
        emit (CandidateLoadedState(loadedCandidate: loadedCandidateList));
      } catch (_) {
        emit(CandidateErrorState());
      }
    });
  }
}
