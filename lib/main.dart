import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 107, 86, 184),
          brightness: Brightness.light,
        ),
        fontFamily: 'SF Pro Display',
      ),
      home: const QuizWidget(),
    );
  }
}

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  bool quizStarted = false;
  int currentQuestionIndex = 0;
  int score = 0;
  bool answerSelected = false;
  int? selectedAnswerIndex;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which of the following describes a business owned and operated by a single person?',
      'answers': [
        'Partnership',
        'Corporation',
        'Cooperative',
        'Sole Proprietorship'
      ],
      'correctAnswer': 3,
    },
    {
      'question': 'What does the acronym CEO stand for?',
      'answers': ['Corporate External Operator', 'Chief Executive Officer', 'Central Equity Office', 'Chief Energy Officer'],
      'correctAnswer': 1,
    },

    {
      'question': 'What is the main goal of Human Resources (HR) in a business??',
      'answers': ['To manage company finances', 'To repair office machinery', 'To design new products', 'To manage and support employees'],
      'correctAnswer': 3,
    },
    
  ];

  void startQuiz() {
    setState(() {
      quizStarted = true;
      currentQuestionIndex = 0;
      score = 0;
      answerSelected = false;
      selectedAnswerIndex = null;
    });
  }

  void selectAnswer(int answerIndex) {
    setState(() {
      selectedAnswerIndex = answerIndex;
      answerSelected = true;
      if (answerIndex == questions[currentQuestionIndex]['correctAnswer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        answerSelected = false;
        selectedAnswerIndex = null;
      } else {
        quizStarted = false;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      quizStarted = false;
      currentQuestionIndex = 0;
      score = 0;
      answerSelected = false;
      selectedAnswerIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 180, 204),
      body: SafeArea(
        child: !quizStarted && currentQuestionIndex == 0 && score == 0
            ? buildStartView()
            : quizStarted
                ? buildQuizView()
                : buildEndView(),
      ),
    );
  }

  Widget buildStartView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 40),
            const Text(
              'Ready to test your\nknowledge?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 120, 76, 166),
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '${questions.length} questions await you',
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 12, 6, 18),
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: startQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 57, 196),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuizView() {
    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Column(
      children: [
        // Progress bar
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 160, 80, 225),
                    ),
                  ),
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 29, 20, 61),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color.fromARGB(255, 220, 208, 243),
                  color: const Color.fromARGB(255, 41, 28, 90),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Question card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 255, 243, 251),
                        Color.fromARGB(255, 255, 243, 251),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 234, 233, 238).withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    currentQuestion['question'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 22, 1, 43),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // Answer options
                ...List.generate(
                  4,
                  (index) {
                    final isSelected = selectedAnswerIndex == index;
                    final isCorrect = index == currentQuestion['correctAnswer'];
                    final showResult = answerSelected;

                    Color getColor() {
                      if (!showResult) {
                        return isSelected ? const Color.fromARGB(255, 185, 157, 243) : const Color(0xFFFFF8F3);
                      }
                      if (isCorrect) return const Color.fromARGB(255, 162, 224, 179);
                      if (isSelected && !isCorrect) return const Color.fromARGB(255, 228, 168, 168);
                      return const Color.fromARGB(255, 235, 225, 217);
                    }

                    Color getBorderColor() {
                      if (!showResult) {
                        return isSelected ? const Color(0xFFB4A5E8) : const Color(0xFFE8DEFC);
                      }
                      if (isCorrect) return const Color(0xFF81C995);
                      if (isSelected && !isCorrect) return const Color(0xFFFF9B9B);
                      return const Color(0xFFE8DEFC);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: answerSelected ? null : () => selectAnswer(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: getColor(),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: getBorderColor(),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: getBorderColor().withOpacity(0.2),
                                  border: Border.all(
                                    color: getBorderColor(),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: getBorderColor(),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  currentQuestion['answers'][index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6B5B7C),
                                  ),
                                ),
                              ),
                              if (showResult && isCorrect)
                                const Icon(Icons.check_circle, color: Color(0xFF81C995)),
                              if (showResult && isSelected && !isCorrect)
                                const Icon(Icons.cancel, color: Color(0xFFFF9B9B)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                if (answerSelected) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 183, 166, 245),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'See Results',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEndView() {
    final percentage = (score / questions.length * 100).round();
    final isPerfect = score == questions.length;
    final isGood = percentage >= 70;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Quiz Complete!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B5B7C),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF8F3),
                    Color(0xFFFFF3F8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFB4A5E8).withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9B8BA8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB4A5E8),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '/${questions.length}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD4C5E0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9B8BA8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: restartQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4A5E8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}