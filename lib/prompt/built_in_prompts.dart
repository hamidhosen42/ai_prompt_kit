import 'prompt_template.dart';

class AiPrompts {
  static PromptTemplate summarize(String text) {
    return PromptTemplate(
      template: "Summarize the following text:\n{text}",
      variables: {"text": text},
    );
  }

  static PromptTemplate sentiment(String text) {
    return PromptTemplate(
      template: "Analyze the sentiment of this text:\n{text}",
      variables: {"text": text},
    );
  }
}