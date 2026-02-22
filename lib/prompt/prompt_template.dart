import '../config/ai_language.dart';

class PromptTemplate {
  final String template;
  final Map<String, String> variables;
  final AiLanguage language;

  PromptTemplate({
    required this.template,
    required this.variables,
    this.language = AiLanguage.english,
  });

  String build() {
    String output = template;

    variables.forEach((key, value) {
      output = output.replaceAll('{$key}', value);
    });

    if (language == AiLanguage.auto) {
      return output;
    }

    return "Respond strictly in ${language.label}.\n\n$output";
  }
}