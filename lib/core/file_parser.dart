import 'dart:io';

import 'package:doc_text/doc_text.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:path/path.dart' as path;

import '../models/question_model.dart';
import '../models/quiz_model.dart';

class FileParser {
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
    final String? fileContent = await _extractString(filePath);
    final List<QuestionModel> questions = [];

    final wholeQuestionRE = RegExp(
      r'<question>(.*?)((?=<question>)|$)',
      dotAll: true,
    );
    final questionRE = RegExp(r'<question>(.*?)(?=<variant>)', dotAll: true);
    final variantRE = RegExp(r'<variant>(.*?)((?=<variant>)|$)', dotAll: true);

    if (fileContent == null) throw Exception('File type is not doc or docx');

    if (!fileContent.contains('<question>')) {
      throw Exception('Quiz should be in <question>, <variant> format');
    }

    final questionMatches = wholeQuestionRE.allMatches(fileContent);

    for (final questionMatch in questionMatches) {
      final wholeQuestionText = questionMatch.group(0)!.trim();
      final questionText =
          questionRE.firstMatch(wholeQuestionText)!.group(1)!.trim();

      final variantMatches = variantRE.allMatches(wholeQuestionText);

      Map<int, String> variants = {};
      for (int i = 0; i < variantMatches.length; i++) {
        final variantMatch = variantMatches.elementAt(i);
        variants.addAll({i + 1: variantMatch.group(1)!.trim()});
      }

      final shuffledVariants = variants.entries.toList()..shuffle();
      final shuffledVariantsMap = {
        for (final variant in shuffledVariants) variant.key: variant.value
      };

      questions.add(QuestionModel(
        question: questionText,
        variants: shuffledVariantsMap,
      ));
    }

    return QuizModel(
      quizName: getBasenameWithoutExt(filePath),
      questions: questions,
    );
  }

  static String getBasename(String filePath) => path.basename(filePath);

  static String getBasenameWithoutExt(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }
}
