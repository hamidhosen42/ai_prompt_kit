enum AiLanguage {
  auto("the same language as the user input"),
  english("English"),
  bengali("Bengali"),
  arabic("Arabic"),
  hindi("Hindi"),
  spanish("Spanish"),
  french("French"),
  german("German"),
  chinese("Chinese"),
  japanese("Japanese");

  final String label;
  const AiLanguage(this.label);
}