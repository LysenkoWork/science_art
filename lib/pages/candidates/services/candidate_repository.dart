import 'package:science_art/pages/candidates/services/candidate_api_provider.dart';

import '../../../model/candidate_model.dart';

class CandidateRepository {
  final CandidateApiProvider _participantProvider = CandidateApiProvider();

  Future<List<Candidate>> getAllCandidates() =>
      _participantProvider.getList();
}
