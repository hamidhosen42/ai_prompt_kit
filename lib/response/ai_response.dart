class AiResponse {
  final String text;
  final int? tokens;
  final String? error;

  const AiResponse({
    required this.text,
    this.tokens,
    this.error,
  });

  bool get hasError => error != null;
}
