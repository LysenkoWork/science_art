import '../../../model/candidate_model.dart';

abstract class CandidateState {}

class CandidateEmptyState extends CandidateState {}

class CandidateLoadingState extends CandidateState {}

class CandidateLoadedState extends CandidateState {
  List<Candidate> loadedCandidates;

  CandidateLoadedState({
    required this.loadedCandidates,
  });
}

class CandidateErrorState extends CandidateState{}
