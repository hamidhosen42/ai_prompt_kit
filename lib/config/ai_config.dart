class AiConfig {
  final String apiKey;
  final String baseUrl;
  final String model;

  const AiConfig({
    required this.apiKey,
    required this.baseUrl,
    this.model = "gpt-4o",
  });
}
