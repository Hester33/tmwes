//*----- Sign Up Screen Text -----*//
const String termsAndConditions =
    "This policy sets out the basis on which any personal data we collect from you, or you provide us will be processed by us. Before we process any of your data, we will need your explicit consent.\n 1. Information we collect from you\n 2. Information you gave us.\n 3. Information we collect from you.\n 4. Anonymised data. \n\nConsents:\n 1. I confirm that I have read and understood how and why my data will be collected.\n 2. I confirm that I have read and understood the contents of this Privacy Policy.\n 3. I acknowledge my right to withdraw consent to the processing of sensitive personal data.\n\nHere are the main things to know:\n 1. We are a responsible software company. We respect your privacy and we have taken steps to protect data.\n 2. We may vary our terms from time to time. But you will be notified.\n\n TMWES is an application that predict chances of migraine exacerbation based on HIT-6 score and giving health recommendation that based on current weather.\n For any enquiry, contact us through: 1181203140@student.mmu.edu.my";

//*----- Terms Of Use Text -----*//
const String termsOfUse =
    "Welcome to the Treat Migraine Weather Experience System (TMWES) mobile application!\nBy using this application, you agree to the following terms and conditions:\n\n1. Application Purpose:\nTMWES is a dedicated mobile application designed to assist individuals suffering from weather-related migraines. The application aims to provide support in managing migraines by tracking weather changes, offering health advice based on weather conditions, collecting migraine data, generating the Headache Impact Test (HIT-6) for evaluating the impact of migraines on daily life, and generating reports for doctor evaluation.\n\n2. Personal Responsibility:\nYou understand and acknowledge that TMWES is not a substitute for professional medical advice or treatment. The application is intended to complement, not replace, the relationship between you and your healthcare provider. It is your responsibility to consult with a healthcare professional for any medical concerns or advice.\n\n3. User Data:\nTMWES may collect and store personal data, including but not limited to your email address, login credentials, and migraine data. We respect your privacy and will handle your personal data in accordance with our Privacy Notice. By using TMWES, you consent to the collection, storage, and use of your data as described in the Privacy Notice. (https://www.mmu.edu.my/privacy-notice/)\n\n4. Intellectual Property:\nThe TMWES application, including its content, features, and designs, is protected by intellectual property rights. You agree not to reproduce, modify, distribute, or create derivative works based on the application or its content without prior written permission from the rights holder.\n\n5. User Conduct:\nWhile using TMWES, you agree to comply with all applicable laws and regulations. You will not engage in any activity that may disrupt or interfere with the proper functioning of the application or compromise its security.\n\nIf you have any questions or concerns about these Terms of Use, please contact us at \n1181203140@student.mmu.edu.my.\n\nBy using the TMWES application, you acknowledge that you have read, understood, and agreed to these Terms of Use.";

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
  "Take medication at the first sign of an oncoming headache.",
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
    'questionText': 'When you have headaches, how often is the pain severe?',
  },
  {
    'questionIndex': 1,
    'questionText':
        'How often do headaches limit your ability to do usual daily activities including household work, work, school, or social activities?',
  },
  {
    'questionIndex': 2,
    'questionText':
        'When you have a headache, how often do you wish you could lie down?',
  },
  {
    'questionIndex': 3,
    'questionText':
        'In the past 4 weeks, how often have you felt too tired to do work or daily activities because of your headaches?',
  },
  {
    'questionIndex': 4,
    'questionText':
        'In the past 4 weeks, how often have you felt fed up or irritated because of your headaches?',
  },
  {
    'questionIndex': 5,
    'questionText':
        'In the past 4 weeks, how often did headaches limit your ability to concentrate on work or daily activities?',
  },
];

final answers = [
  {'ansIndex': 0, 'text': 'Never', 'score': 6},
  {'ansIndex': 1, 'text': 'Rarely', 'score': 8},
  {'ansIndex': 2, 'text': 'Sometimes', 'score': 10},
  {'ansIndex': 3, 'text': 'Very Often', 'score': 11},
  {'ansIndex': 4, 'text': 'Always', 'score': 13},
];

//*----- Migraine Precautions -----*//
const List<String> severeMigraine = [
  "Take your HIT-6 results to your doctor for treatment!",
  "Follow your healthcare professional's instructions and take any prescribed medications.",
  "Find a quiet and dark room to rest in to reduce external stimuli such as noise and light.",
];

const List<String> moderateMigraine = [
  "Apply cold or hot packs to the head or neck to relief pain.",
  "Maintain a consistent sleep routine to help regulate your body's natural rhythms.",
  "Practice stress management techniques, such as relaxation exercises or meditation that help you unwind.",
];

const List<String> lowLvlMigraine = [
  "Make sure to drink an adequate amount of water throughout the day.",
  "Avoid or minimize exposure to any potential food and drink triggers.",
  "Adopt a well-balanced diet, exercise regularly, and ensure you get sufficient sleep."
];

//*----- Record Migraine Text -----*//
final painLvl = [
  {'index': 0, 'text': 'Very Mild'},
  {'index': 1, 'text': 'Tolerable'},
  {'index': 2, 'text': 'Discomforting'},
  {'index': 3, 'text': 'Distressing'},
  {'index': 4, 'text': 'Very Distressing'},
  {'index': 5, 'text': 'Painful'},
  {'index': 6, 'text': 'Intense'},
  {'index': 7, 'text': 'Very Intense'},
  {'index': 8, 'text': 'Horrible'},
  {'index': 9, 'text': 'Unbearable'},
];

List<Map<String, dynamic>> painPosition = [
  {'index': 0, 'text': 'Left Side'},
  {'index': 1, 'text': 'Right Side'},
  {'index': 2, 'text': 'Both Side'},
  {'index': 3, 'text': 'Forehead'},
  {'index': 4, 'text': 'Back of Head'},
  {'index': 5, 'text': 'Behind of eye'},
  {'index': 6, 'text': 'Temples'},
  {'index': 7, 'text': 'From Neck'},
];

List<Map<String, dynamic>> triggers = [
  {'index': 0, 'text': 'Alcohol'},
  {'index': 1, 'text': 'Caffeine'},
  {'index': 2, 'text': 'Change in Weather'},
  {'index': 3, 'text': 'Stress'},
];

List<Map<String, dynamic>> medicines = [
  {'index': 0, 'text': 'Advil'},
  {'index': 1, 'text': 'Aspirin'},
  {'index': 2, 'text': 'Ibuprofen'},
  {'index': 3, 'text': 'Naproxen'},
  {'index': 4, 'text': 'Paracetamol'},
];

//*----- FAQ Text -----*//
const String whatIsTMWESDesc =
    "Treat Migraine Weather Experience System (TMWES) is an mobile application designed to assist individuals in effectively managing their migraine condition, particularly those triggered by weather changes.\nThe application aims to provide support in managing migraines by tracking weather changes, offering health advice based on weather conditions, collecting migraine data, generating the Headache Impact Test (HIT-6) for evaluating the impact of migraines on daily life, and generating reports for doctor evaluation.";
const String howTMWESHelpDesc =
    "TMWES offers a range of features to help individuals manage their migraines effectively. It tracks weather changes and provides personalized health recommendations based on the weather conditions. Users can maintain a migraine diary to track pain events and their correlation with weather conditions. The Headache Impact Test (HIT-6) assesses the impact of migraines on daily life. The application also generates reports for doctors based on recorded migraine data, enabling better evaluation and treatment planning.";
const String whtIsHIT6Desc =
    "The six-item Headache Impact Test (HIT-6) was designed specifically for assessing the impact of headaches and has been validated in patients with various headache conditions.\nThe HIT-6 score is divided into four categories: 'little or no impact' with a score range of 0 to 49, 'some impact' with a score range of 50 to 55, 'substantial impact' with a score range of 56 to 59, and 'severe impact' with a score range of 60 to 78.";
const String howManyHIT6Desc =
    "The test is recommended every four weeks. This can help in understanding how the migraine changes over time.";
const String personalDataDesc =
    "TMWES values your privacy and handles your personal data with utmost care. All data collected is stored securely and will only be reported in an aggregate format. Your individual questionnaire responses will remain confidential and accessible only to the MMU research team. Please refer to the Privacy Notice in the application or visit our website for more details on data handling and privacy protection.\n(https://www.mmu.edu.my/privacy-notice/)";
const String replaceProfessionalAdviceDesc =
    "No, TMWES is not a substitute for professional medical advice or treatment. It is designed to complement the relationship between you and your healthcare provider. Always consult with a healthcare professional for personalized medical advice and treatment.";
const String prepareDailyRoutineDesc =
    "Yes, TMWES aims to help individuals prepare for their daily routines by providing information on weather changes and their potential impact on migraines. By tracking weather conditions and offering personalized health recommendations, TMWES enables users to take necessary precautions in line with the weather forecast, helping them manage their condition more effectively.";
