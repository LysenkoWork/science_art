import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:science_art/pages/candidates/bloc/candidate_bloc.dart';
import 'package:science_art/pages/candidates/bloc/candidate_event.dart';
import 'package:science_art/pages/candidates/services/candidate_repository.dart';
import 'package:science_art/pages/candidates/widgets/candidates_list.dart';
import '../../../model/models.dart';
import '../bloc/candidate_state.dart';

class CandidatePage extends StatelessWidget {
  CandidatePage({Key? key, this.user}) : super(key: key);
  User? user;

  @override
  Widget build(BuildContext context) {
    print('Старт билдера');
    return RepositoryProvider(
      create: (context) => CandidateRepository(),
      child: BlocProvider(
        create: (context) => CandidateBloc(candidateRepository: context.read<CandidateRepository>())
          ..add(CandidateLoadEvent()),
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(user != null ? 'Вы авторизованны как Эксперт' : ''),
          ),
          body: BlocBuilder<CandidateBloc, CandidateState>(
            builder: (context, state) {
              if (state is CandidateEmptyState) {
                return const Text('Заявок пока нет');
              }
              if (state is CandidateErrorState) {
                return const Center(
                  child: Text('Произошла ошибка при загрузке файла!'),
                );
              }
              if (state is CandidateLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CandidateLoadedState) {
                return CandidatesList(
                  candidates: state.loadedCandidates,
                  user: user,
                );
                //return Text(state.loadedCandidate[2].name.toString());
              }
              return const SizedBox();
            },
          ),
          //body: const CandidatesList(),
        ),
      ),
    );
  }
}
