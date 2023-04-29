import '../../../model/candidate_model.dart';

class CandidateRepository {
  final CandidateRepository _participantProvider = CandidateRepository();

  Future<List<Candidate>> getAllCandidates() =>
      _participantProvider.getAllCandidates();
}
