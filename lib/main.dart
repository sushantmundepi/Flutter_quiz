import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' UFC QUIZ '),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UFC QUIZ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text('Start Quiz', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _submitted = false;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'Who holds the most UFC wins in history?',
      'options': ['Demetrious Johnson', 'Georges St-Pierre', 'Charles Oliveira', 'Anderson Silva'],
      'correctIndex': 0,
    },
    {
      'question': 'What is the nickname of the first UFC heavyweight champion?',
      'options': ['The Iceman', 'The Spider', 'The Phenom', 'The Count'],
      'correctIndex': 3,
    },
    {
      'question': 'Which country has produced the most UFC champions?',
      'options': ['Brazil', 'United States', 'Canada', 'Russia'],
      'correctIndex': 0,
    },
    {
      'question': 'What is the name of the iconic arena where UFC events are often held?',
      'options': ['Madison Square Garden', 'T-Mobile Arena', 'UFC Apex', 'MGM Grand Garden Arena'],
      'correctIndex': 1,
    },
    {
      'question': 'What is the weight limit for the middleweight division in UFC?',
      'options': ['170-185 pounds', '185-205 pounds', '205-265 pounds', 'Over 265 pounds'],
      'correctIndex': 1,
    },
    {
      'question': 'Which fighter is known for his nickname "The Last Stylebender"?',
      'options': ['Israel Adesanya', 'Robert Whittaker', 'Paulo Costa', 'Alexander'],
      'correctIndex': 0,
    },
    {
      'question': 'Which country is the UFC fighter Israel Adesanya from?',
      'options': ['Nigeria', 'Brazil', 'USA'],
      'correctIndex': 0,
    },
    {
      'question': 'In which weight class did Conor McGregor win his first UFC title?',
      'options': ['Featherweight', 'Lightweight', 'Welterweight'],
      'correctIndex': 0,
    },
    // Add more questions...
  ];

  void _checkAnswer(int selectedIndex) {
  if (_currentIndex <= questions.length - 1 && !_submitted) {
    if (selectedIndex == questions[_currentIndex]['correctIndex']) {
      setState(() {
        _score++;
      });
    }
  }
}


  void _nextQuestion() {
  setState(() {
    if (_currentIndex < questions.length - 1 && !_submitted) {
      _currentIndex++;
    } else if (_currentIndex == questions.length - 1) {
      _submitted = true;
      _submitQuiz();
    }
  });
}


  void _previousQuestion() {
  setState(() {
    if (_currentIndex > 0 && !_submitted) {
      _currentIndex--;
    }
  });
}

  void _submitQuiz() {
  setState(() {
    _submitted = true;
  });

showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Quiz Results'),
      content: Text('Your Score: $_score / ${questions.length}'),
      actions: [
        TextButton(
          onPressed: () {
            _restartQuiz(); // Call _restartQuiz when Restart Quiz is pressed
            Navigator.pop(context);
          },
          child: Text('Restart Quiz', style: TextStyle(color: Colors. blue)),
        ),
      ],
    ),
  );
}


  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UFC QUIZ'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'UFC QUIZ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              title: Text('Home', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Add more drawer items...
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ...((questions[_currentIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: _submitted
                                  ? null
                                  : () {
                                      _checkAnswer(entry.key);
                                      _nextQuestion();
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.blue,
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(entry.value),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _previousQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child:
                        Text('Back', style: TextStyle(color: Colors.white)),
                  ),

SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? null
                      : () {
                          _submitQuiz();
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? () {
                          _restartQuiz();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Restart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_submitted)
              Center(
                child: Text(
                  'Your Score: $_score / ${questions.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_submitted) {
            _nextQuestion();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
