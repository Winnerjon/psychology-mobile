import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/models/quiz_model.dart';
import 'package:psychology_mobile/models/result_model.dart';
import 'package:psychology_mobile/widgets/custom_background.dart';

class ResultScreen extends StatefulWidget {
  static const String routeName = '/result_screen';

  final List<QuizModel> quizzes;

  const ResultScreen({super.key, required this.quizzes});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<ResultModel> results = [];
  bool isLoading = true;

  Future<List<ResultModel>> fetchAllData() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/result.json');
    final json = jsonDecode(data);
    return json['data']
        .map<ResultModel>((e) => ResultModel.fromJson(e))
        .toList();
  }

  Future<List<ResultModel>> _checkQuizzes() async {
    List<ResultModel> list = [];
    List<ResultModel> values = await fetchAllData();
    for (var quiz in widget.quizzes) {
      for (int i = 0; i < values.length; i++) {
        if ((quiz.answer?.type ?? 0) > 0) {
          final value = values[i];
          List<int> que1 = value.questionnaire1 ?? [];
          List<int> que2 = value.questionnaire2 ?? [];
          if (quiz.questionnaire == 1) {
            que1.removeWhere((e) => e == quiz.number);
          } else if (quiz.questionnaire == 2) {
            que2.removeWhere((e) => e == quiz.number);
          }
          if (que1.isEmpty && que2.isEmpty) {
            list.add(value);
            values.removeWhere((e) => e.id == value.id);
          } else {
            values[i] =
                value.copyWith(questionnaire1: que1, questionnaire2: que2);
          }
        }
      }
    }
    return list;
  }

  Future<void> _initState() async {
    results = await _checkQuizzes();
    isLoading = !isLoading;
    setState(() {});
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => NavigationService.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text('Natijalar', style: TextStyle(color: Colors.white)),
        ),
        body: Builder(
          builder: (context) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (results.isEmpty) {
              return const Center(
                child: Text(
                  '😔Afsus, so\'rovnomaga ko\'ra sizda hech qanday qadryatlar aniqlanmadi!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text(
                    'So\'rovnomaga ko\'ra sizda quyidagi qadryatlar aniqlandi:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gilroy'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final result = results[index];
                        return ResultCard(index: index, result: result);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.grey.withOpacity(0.5));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(12).copyWith(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
        //   child: CustomElevatedButton(
        //     onTap: () {
        //       final allResults = ResultService.fetchAllResults();
        //       final saved = SavedResultModel(date: DateTime.now(), result: results);
        //       allResults.add(saved);
        //       allResults.reversed;
        //       ResultService.setAllResults(allResults);
        //       NavigationService.pop(context, true);
        //     },
        //     title: 'Saqlash',
        //   ),
        // ),
      ),
    );
  }
}

class ResultCard extends StatefulWidget {
  final int index;
  final ResultModel result;

  const ResultCard({super.key, required this.index, required this.result});

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => isShow = !isShow),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '${widget.index + 1}. ${widget.result.name ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                    isShow
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white),
              ],
            ),
          ),
        ),
        if (isShow) ...[
          Text(
            widget.result.description ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
        ]
      ],
    );
  }
}
