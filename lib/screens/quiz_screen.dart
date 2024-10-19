import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/common/values/colors.dart';
import 'package:psychology_mobile/models/option_model.dart';
import 'package:psychology_mobile/models/quiz_model.dart';
import 'package:psychology_mobile/screens/result_screen.dart';
import 'package:psychology_mobile/widgets/custom_background.dart';
import 'package:psychology_mobile/widgets/custom_elevated_button.dart';

class QuizScreen extends StatefulWidget {
  static const String routeName = '/quiz_screen';

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final pageController = PageController();
  List<QuizModel> quizzes = [];
  int currentIndex = 0;

  Future<List<QuizModel>> _fetchAllData() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/quiz.json');
    final json = jsonDecode(data);
    return json['data'].map<QuizModel>((e) => QuizModel.fromJson(e)).toList();
  }

  void _initState() async {
    _fetchAllData().then((values) {
      quizzes = values;
      setState(() {});
    });
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      isGradient: quizzes.isNotEmpty && quizzes[currentIndex].number == 0,
      child: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (value) return;
          backButton();
        },
        child: quizzes.isNotEmpty ? Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: backButton,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: quizzes.isNotEmpty
                ? Text(
                    quizzes[currentIndex].number == 0
                        ? 'Yo\'riqnoma'
                        : '${quizzes[currentIndex].questionnaire}-so\'rovnoma',
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              if (quiz.number == 0) {
                return QuestionnaireItem(quiz: quiz);
              }
              return QuizItem(
                quiz: quiz,
                onChange: (value) {
                  quizzes[index] = value;
                  setState(() {});
                },
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: quizzes[currentIndex].number == 0
                ? CustomElevatedButton(
                    onTap: () {
                      quizzes.removeWhere((e) => e.number == quizzes[currentIndex].number && e.questionnaire == quizzes[currentIndex].questionnaire);
                      setState(() {});
                    },
                    title: 'Tanishib chiqdim',
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentIndex - 1 >= 0)
                        OutlinedButton(
                          onPressed: () {
                            currentIndex = currentIndex - 1;
                            pageController.jumpToPage(currentIndex);
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: AppColors.c8E84FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                          child: const Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.navigate_before, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                'Oldingisi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {
                          if (currentIndex + 1 < quizzes.length) {
                            currentIndex = currentIndex + 1;
                            pageController.jumpToPage(currentIndex);
                            setState(() {});
                          } else {
                            if (checkAll()) {
                              NavigationService.pushReplacement(
                                  context, ResultScreen.routeName,
                                  extra: quizzes);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Barcha savollarga javab berish kerak'),
                                ),
                              );
                            }
                          }
                        },
                        color: AppColors.c8E84FF,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              currentIndex + 1 < quizzes.length
                                  ? 'Keyingisi'
                                  : 'Yakunlash',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.navigate_next,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ) : const SizedBox.shrink(),
      ),
    );
  }

  backButton() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Hozir chiqib ketsangiz testni qaytadan boshlashingiz kerak.\nRosdan ham chiqmoqchimisiz?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  NavigationService.pop(context);
                },
                child: const Text(
                  'Yoq',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  NavigationService.pop(context);
                  NavigationService.pop(context);
                },
                child: const Text(
                  'Ha',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool checkAll() {
    for (var e in quizzes) {
      if (e.answer == null) return false;
    }

    return true;
  }
}

class QuizItem extends StatefulWidget {
  final QuizModel quiz;
  final Function(QuizModel) onChange;

  const QuizItem({
    super.key,
    required this.quiz,
    required this.onChange,
  });

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  List<OptionModel> options = [];

  Future<List<OptionModel>> _fetchAllData() async {
    final path = 'assets/data/option_${widget.quiz.questionnaire}.json';
    final data = await DefaultAssetBundle.of(context).loadString(path);
    final json = jsonDecode(data);
    return json['data']
        .map<OptionModel>((e) => OptionModel.fromJson(e))
        .toList();
  }

  void _initState() async {
    _fetchAllData().then((values) {
      options = values;
      setState(() {});
    });
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.c8E84FF,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              '${widget.quiz.number}-savol',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gilroy'),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.quiz.question ?? '',
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelect = option.id == widget.quiz.answer?.id;
                return GestureDetector(
                  onTap: () {
                    final answer = widget.quiz.copyWith(answer: option);
                    widget.onChange.call(answer);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelect ? AppColors.c8E84FF : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  isSelect ? AppColors.mainColor : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1, color: AppColors.mainColor)),
                          child: const Icon(Icons.check,
                              color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option.answer,
                            style: const TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionnaireItem extends StatelessWidget {
  final QuizModel quiz;

  const QuestionnaireItem({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12).copyWith(bottom: 16),
      children: [
        Text(
          '${quiz.questionnaire}-so‘rovnoma',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Gilroy'),
        ),
        const SizedBox(height: 10),
        HtmlWidget(
          quiz.question ?? '',
          textStyle: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
