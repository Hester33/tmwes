//*----- Sign Up Screen Text -----*//
const String termsAndConditions =
    "This policy sets out the basis on which any personal data we collect from you, or you provide us will be processed by us. Before we process any of your data, we will need your explicit consent.\n 1. Information we collect from you\n 2. Information you gave us.\n 3. Information we collect from you.\n 4. Anonymised data. \n\nConsents:\n 1. I confirm that I have read and understood how and why my data will be collected.\n 2. I confirm that I have read and understood the contents of this Privacy Policy.\n 3. I acknowledge my right to withdraw consent to the processing of sensitive personal data.\n\nHere are the main things to know:\n 1. We are a responsible software company. We respect your privacy and we have taken steps to protect data.\n 2. We may vary our terms from time to time. But you will be notified.\n\n TMWES is an application that predict chances of migraine exacerbation based on HIT-6 score and giving health recommendation that based on current weather.\n For any enquiry, contact us through: 1181203140@student.mmu.edu.my";

//*----- Health Recommendation Text -----*//
const List<String> clouds = [
  "Spend time in the shade when outdoors.",
  "Drink sports drinks to replenish electrolytes.",
  "Wear a wide-brimmed hat or a cap that covers your face."
];

const List<String> rain = [
  "Bring an umbrella to protect yourself from wind and rain.",
  "Drink a minimum of eight glasses of water per day.",
  "Practice relaxation techniques if you're experiencing stress."
];

const List<String> thunderstorm = [
  "Stay inside before, during and after the storm.",
  "Keep rescue medications handy.",
  "Stay away from the foods that contain caffeine, monosodium glutamate (MSG) and nitrates which might caused migraines."
];

const List<String> otherWeather = [
  "Get 7 to 8 hours of sleep each night.",
  "ETake medication at the first sign of an oncoming headache.",
  "Keep an eye on temperature and pressure forecast."
];

// Get 7 to 8 hours of sleep each night.
// Drink a minimum of eight glasses of water per day.
// Exercise most days of the week.
// Eat a balanced diet and avoid skipping meals.
// Practice relaxation techniques if you’re experiencing stress.
//Keep rescue medications handy.
//Stay away from foods that cause migraines, like those that contain caffeine, monosodium glutamate (MSG) and nitrates

//*----- HIT-6 questions -----*//
final Oriquestions = [
  {
    'questionText':
        'Q1. When you have headaches, how often is the pain severe?',
    'answers': [
      {'text': 'Never', 'score': 6},
      {'text': 'Rarely', 'score': 8},
      {'text': 'Sometimes', 'score': 10},
      {'text': 'Very Often', 'score': 11},
      {'text': 'Always', 'score': 13},
    ],
  },
  {
    'questionText':
        'Q2. How often do headaches limit your ability to do usual daily activities including household work, work, school, or social activities?',
    'answers': [
      {'text': 'Never', 'score': 6},
      {'text': 'Rarely', 'score': 8},
      {'text': 'Sometimes', 'score': 10},
      {'text': 'Very Often', 'score': 11},
      {'text': 'Always', 'score': 13},
    ],
  },
  {
    'questionText':
        'Q3. When you have a headache, how often do you wish you could lie down?',
    'answers': [
      {'text': 'Never', 'score': 6},
      {'text': 'Rarely', 'score': 8},
      {'text': 'Sometimes', 'score': 10},
      {'text': 'Very Often', 'score': 11},
      {'text': 'Always', 'score': 13},
    ],
  },
  {
    'questionText':
        'Q4. In the past 4 weeks, how often have you felt too tired to do work or daily activities because of your headaches?',
    'answers': [
      {'text': 'Never', 'score': 6},
      {'text': 'Rarely', 'score': 8},
      {'text': 'Sometimes', 'score': 10},
      {'text': 'Very Often', 'score': 11},
      {'text': 'Always', 'score': 13},
    ],
  },
  {
    'questionText':
        'Q5. In the past 4 weeks, how often have you felt fed up or irritated because of your headaches?',
    'answers': [
      {'text': 'Never', 'score': 6},
      {'text': 'Rarely', 'score': 8},
      {'text': 'Sometimes', 'score': 10},
      {'text': 'Very Often', 'score': 11},
      {'text': 'Always', 'score': 13},
    ],
  },
  {
    'questionText':
        'Q6. In the past 4 weeks, how often did headaches limit your ability to concentrate on work or daily activities?',
    'answers': [
      {'text': 'Never', 'score': 6},
      {'text': 'Rarely', 'score': 8},
      {'text': 'Sometimes', 'score': 10},
      {'text': 'Very Often', 'score': 11},
      {'text': 'Always', 'score': 13},
    ],
  },
];

final finalQuestions = [
  'Q1. When you have headaches, how often is the pain severe?',
  'Q2. How often do headaches limit your ability to do usual daily activities including household work, work, school, or social activities?',
  'Q3. When you have a headache, how often do you wish you could lie down?',
  'Q4. In the past 4 weeks, how often have you felt too tired to do work or daily activities because of your headaches?',
  'Q5. In the past 4 weeks, how often have you felt fed up or irritated because of your headaches?',
  'Q6. In the past 4 weeks, how often did headaches limit your ability to concentrate on work or daily activities?',
];

final questions = [
  {
    'questionIndex': 0,
    'questionText':
        'Q1. When you have headaches, how often is the pain severe?',
    'selectedAnswer': -1,
    'selectedAnswerScore': 0,
  },
  {
    'questionIndex': 1,
    'questionText':
        'Q2. How often do headaches limit your ability to do usual daily activities including household work, work, school, or social activities?',
    'selectedAnswer': -1,
    'selectedAnswerScore': 0,
  },
  {
    'questionIndex': 2,
    'questionText':
        'Q3. When you have a headache, how often do you wish you could lie down?',
    'selectedAnswer': -1,
    'selectedAnswerScore': 0,
  },
  {
    'questionIndex': 3,
    'questionText':
        'Q4. In the past 4 weeks, how often have you felt too tired to do work or daily activities because of your headaches?',
    'selectedAnswer': -1,
    'selectedAnswerScore': 0,
  },
  {
    'questionIndex': 4,
    'questionText':
        'Q5. In the past 4 weeks, how often have you felt fed up or irritated because of your headaches?',
    'selectedAnswer': -1,
    'selectedAnswerScore': 0,
  },
  {
    'questionIndex': 5,
    'questionText':
        'Q6. In the past 4 weeks, how often did headaches limit your ability to concentrate on work or daily activities?',
    'selectedAnswer': -1,
    'selectedAnswerScore': 0,
  },
];

final answers = [
  {'ansIndex': 0, 'selected': -1, 'text': 'Never', 'score': 6},
  {'ansIndex': 1, 'selected': -1, 'text': 'Rarely', 'score': 8},
  {'ansIndex': 2, 'selected': -1, 'text': 'Sometimes', 'score': 10},
  {'ansIndex': 3, 'selected': -1, 'text': 'Very Often', 'score': 11},
  {'ansIndex': 4, 'selected': -1, 'text': 'Always', 'score': 13},
];
