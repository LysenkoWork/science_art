import '../../../model/candidate_model.dart';

abstract class CandidateState {}

class CandidateEmptyState extends CandidateState {}

class CandidateLoadingState extends CandidateState {}

class CandidateLoadedState extends CandidateState {
  List<Candidate> loadedCandidate;

  CandidateLoadedState({
    required this.loadedCandidate,
  });
}

class CandidateErrorState extends CandidateState{}
