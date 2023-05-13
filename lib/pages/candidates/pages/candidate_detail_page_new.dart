import 'package:flutter/material.dart';
import 'package:science_art/app/theme/app_pallete.dart';
import 'package:science_art/model/ballov_model.dart';
import 'package:science_art/model/candidate_model.dart';
import 'package:science_art/model/models.dart';
import 'package:science_art/pages/candidates/services/candidate_api_provider.dart';

class CandidateDetailPageNew extends StatefulWidget {
  const CandidateDetailPageNew({
    Key? key,
    required this.candidate,
    this.user,
    this.ballov,
  }) : super(key: key);
  final Candidate candidate;
  final User? user;
  final String? ballov;

  @override
  State<CandidateDetailPageNew> createState() => _CandidateDetailPageNewState();
}

class _CandidateDetailPageNewState extends State<CandidateDetailPageNew> {
  CandidateApiProvider candidateRepository = CandidateApiProvider();
  int _value = 0;

  @override
  void initState() {
    if (widget.user != null) {
      _value = int.parse(widget.ballov!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final headTextStyle = TextStyle(fontSize: mediaQuery.size.width / 40);
    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (widget.user != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ваша оценка: ',
                      style: headTextStyle,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SegmentedButton<int>(
                      segments: [
                        for (int index = 1; index <= 10; ++index)
                          ButtonSegment<int>(
                            value: index,
                            label: Text(
                              '$index',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                      ],
                      selected: <int>{_value},
                      onSelectionChanged: (Set<int> newSelection) {
                        setState(
                          () {
                            _value = newSelection.first;
                            candidateRepository.addRating(
                              widget.candidate.id!,
                              widget.user!.id!,
                              _value.toString(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              widget.candidate.assetsFileName != null
                  ? Container(
                      height: 1000,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                                'assets/candidate_image/${widget.candidate.assetsFileName}')
                            // image: MemoryImage(
                            //   base64Decode((widget.candidate.filedata) as String),
                            // ),
                            ),
                      ),
                    )
                  : Text(widget.candidate.assetsFileName),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.candidate.name ?? '',
                    style: headTextStyle,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.candidate.surname ?? '',
                    style: headTextStyle,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.candidate.patronymic ?? '',
                    style: headTextStyle,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.candidate.section ?? '',
                style: headTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                widget.candidate.ageCategory ?? '',
                style: headTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                widget.candidate.workname ?? '',
                style: headTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                widget.candidate.job ?? '',
                style: headTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                widget.candidate.leadership ?? '',
                style: headTextStyle,
              ),
              const SizedBox(height: 20),
              if (widget.user != null)
                Text(
                  widget.candidate.email ?? '',
                  style: headTextStyle,
                ),
              const SizedBox(height: 20),
              if (widget.user != null)
                Text(
                  widget.candidate.phoneNumber ?? '',
                  style: headTextStyle,
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
