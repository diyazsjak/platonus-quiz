import 'dart:developer';
import 'dart:io';

import 'package:doc_text/doc_text.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:path/path.dart' as path;

import '../database/question_manager.dart';
import '../database/quiz_manager.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

final _wholeQuestionRE = RegExp(
  r'<question>(.*?)((?=<question>)|$)',
  dotAll: true,
);
final _questionRE = RegExp(r'<question>(.*?)(?=<variant>)', dotAll: true);
final _variantRE = RegExp(r'<variant>(.*?)((?=<variant>)|$)', dotAll: true);

class QuizParserService {
  static Future<String?> _extractString(String filePath) async {
    final String extension = path.extension(filePath);
    final String? content;

    if (extension == '.doc') {
      content = await DocText().extractTextFromDoc(filePath);
    } else if (extension == '.docx') {
      final bytes = await File(filePath).readAsBytes();
      content = docxToText(bytes);
    } else {
      throw Exception('File type is not doc or docx');
    }

    return content;
  }

  static Future<QuizModel> parseFileToQuiz(String filePath) async {
    final quizManager = QuizManager();
    final String? fileContent = await _extractString(filePath);

    if (fileContent == null) throw Exception('File type is not doc or docx');
    if (!fileContent.contains('<question>')) {
      throw Exception('Quiz should be in <question>, <variant> format');
    }

    final quizName = getBasenameWithoutExt(filePath);
    final isExists = await quizManager.isExists(quizName);
    log(isExists ? 'Has quiz with this name' : 'No quiz with this name');

    int? id;
    if (!isExists) id = await quizManager.insert(quizName);
    final questions = await _parseQuestions(fileContent, id);

    return QuizModel(quizName: quizName, questions: questions);
  }

  static Future<List<QuestionModel>> _parseQuestions(
    String fileContent,
    int? quizId,
  ) async {
    final questionManager = QuestionManager();
    final questionMatches = _wholeQuestionRE.allMatches(fileContent);
    final List<QuestionModel> questions = [];

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

      if (quizId != null) {
        await questionManager.insert(
          quizId: quizId,
          question: questionText,
          variants: variantsText,
        );
      }

      questions.add(QuestionModel(
        question: questionText,
        variants: _getShuffledVariantsMap(variants),
      ));
    }

    return questions;
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
