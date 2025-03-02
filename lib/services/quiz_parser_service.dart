import 'dart:io';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:path/path.dart' as path;

import '../core/database_singleton.dart';
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
  final _database = DatabaseSingleton().database;

  Future<String> _extractString(String filePath) async {
    final String extension = path.extension(filePath);

    if (extension == '.docx') {
      final bytes = await File(filePath).readAsBytes();
      return docxToText(bytes);
    } else {
      throw WrongFileFormatException();
    }
  }

  Future<void> saveQuiz(String filePath) async {
    final quizManager = QuizDatabaseService();
    final questionManager = QuestionDatabaseService();

    await _database.transaction(() async {
      final fileContent = await _extractString(filePath);

      if (!fileContent.contains('<question>')) {
        throw WrongQuizFormatException();
      }

      final quizName = getBasenameWithoutExt(filePath);
      if (await quizManager.isExists(quizName)) {
        throw QuizAlreadyExistsException();
      }

      final questions = await _parseQuestions(fileContent);
      final id = await quizManager.insert(
        quizName: quizName,
        fileContent: fileContent,
        length: questions.length,
      );
      for (final question in questions) {
        await questionManager.insert(
          quizId: id,
          question: question['question']!,
          variants: question['variants']!,
        );
      }
    });
  }

  Future<List<Map<String, String>>> _parseQuestions(
    String fileContent,
  ) async {
    final questionMatches = _wholeQuestionRE.allMatches(fileContent);
    final questions = <Map<String, String>>[];

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

      questions.add({'question': questionText, 'variants': variantsText});
    }

    return questions;
  }

  static Map<int, String> getVariantsMapFromString(String variants) {
    final variantMatches = _variantRE.allMatches(variants);

    Map<int, String> variantsMap = {};
    for (int i = 0; i < variantMatches.length; i++) {
      final variantMatch = variantMatches.elementAt(i);
      variantsMap.addAll({i + 1: variantMatch.group(1)!.trim()});
    }

    return variantsMap;
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

  String getBasename(String filePath) => path.basename(filePath);

  String getBasenameWithoutExt(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }
}
