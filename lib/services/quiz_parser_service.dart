import 'dart:io';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:path/path.dart' as path;

import '../core/exceptions.dart';
import 'question_database_service.dart';
import 'quiz_database_service.dart';

final _wholeQuestionRE = RegExp(
  r'<question>(.*?)((?=<question>)|$)',
  dotAll: true,
  caseSensitive: false,
);
final _questionRE = RegExp(
  r'<question>(.*?)(?=<variant>)',
  dotAll: true,
  caseSensitive: false,
);
final _variantRE = RegExp(
  r'<variant>(.*?)((?=<variant>)|$)',
  dotAll: true,
  caseSensitive: false,
);

class QuizParserService {
  static Future<String> _extractString(String filePath) async {
    final String extension = path.extension(filePath);

    if (extension == '.docx') {
      final bytes = await File(filePath).readAsBytes();
      return docxToText(bytes);
    } else {
      throw WrongFileFormatException();
    }
  }

  static Future<void> saveQuiz(String filePath) async {
    final quizManager = QuizDatabaseService();
    final fileContent = await _extractString(filePath);

    if (!fileContent.contains('<question>')) {
      throw WrongQuizFormatException();
    }

    final quizName = getBasenameWithoutExt(filePath);
    if (await quizManager.isExists(quizName)) {
      throw QuizAlreadyExistsException();
    }

    final id = await quizManager.insert(quizName);
    final questionLength = await _saveQuestions(fileContent, id);
    await quizManager.updateQuestionAmount(id, questionLength);
  }

  static Future<int> _saveQuestions(
    String fileContent,
    int quizId,
  ) async {
    final questionManager = QuestionDatabaseService();
    final questionMatches = _wholeQuestionRE.allMatches(fileContent);
    int questionsLength = 0;

    for (final questionMatch in questionMatches) {
      final wholeQuestionText = questionMatch.group(0)!.trim();
      final questionText =
          _questionRE.firstMatch(wholeQuestionText)!.group(1)!.trim();

      final variantMatches = _variantRE.allMatches(wholeQuestionText);

      Map<int, String> variants = {};
      String variantsText = '';
      for (int i = 0; i < variantMatches.length; i++) {
        final variantMatch = variantMatches.elementAt(i);
        variants.addAll({i + 1: variantMatch.group(1)!.trim()});

        variantsText += variantMatch.group(0)!.trim();
      }

      await questionManager.insert(
        quizId: quizId,
        question: questionText,
        variants: variantsText,
      );
      questionsLength++;
    }

    return questionsLength;
  }

  static Map<int, String> getShuffledVariantsMapFromString(String variants) {
    final variantMatches = _variantRE.allMatches(variants);

    Map<int, String> variantsMap = {};
    for (int i = 0; i < variantMatches.length; i++) {
      final variantMatch = variantMatches.elementAt(i);
      variantsMap.addAll({i + 1: variantMatch.group(1)!.trim()});
    }

    return _getShuffledVariantsMap(variantsMap);
  }

  static Map<int, String> _getShuffledVariantsMap(Map<int, String> variants) {
    final shuffledVariants = variants.entries.toList()..shuffle();
    final shuffledVariantsMap = {
      for (final variant in shuffledVariants) variant.key: variant.value
    };

    return shuffledVariantsMap;
  }

  static String getBasename(String filePath) => path.basename(filePath);

  static String getBasenameWithoutExt(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }
}
