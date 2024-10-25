import 'dart:io';

import 'package:doc_text/doc_text.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:path/path.dart' as path;

import '../models/question_model.dart';

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

  static Future<List<QuestionModel>> parseFileToQuiz(String filePath) async {
    final String? fileContent = await _extractString(filePath);
    final List<QuestionModel> questions = [];

    final questionRegExp = RegExp(r'<question>(.*?)<variant>', dotAll: true);
    final variantRegExp =
        RegExp(r'<variant>(.*?)((?=<question>)|\$)', dotAll: true);

    if (fileContent == null) throw Exception('File type is not doc or docx');

    if (!fileContent.contains('<question>')) {
      throw Exception('Quiz should be in <question>, <variant> format');
    }

    final Iterable<RegExpMatch> questionMatches =
        questionRegExp.allMatches(fileContent);

    for (final questionMatch in questionMatches) {
      String questionText = questionMatch.group(1)!.trim();

      List<String> variants = [];
      final Iterable<RegExpMatch> variantMatches =
          variantRegExp.allMatches(questionMatch.group(0)!);

      for (final variantMatch in variantMatches) {
        variants.add(variantMatch.group(1)!.trim());
      }

      questions.add(QuestionModel(question: questionText, variants: variants));
    }

    return questions;
  }

  static String getBasename(String filePath) => path.basename(filePath);

  static String getBasenameWithoutExt(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }
}
