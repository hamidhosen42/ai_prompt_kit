import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/ai_config.dart';
import '../prompt/prompt_template.dart';
import '../response/ai_response.dart';

class AiClient {
  final AiConfig config;

  AiClient(this.config);

  Future<AiResponse> complete({required String prompt}) {
    return _send(prompt);
  }

  Future<AiResponse> run(PromptTemplate template) {
    return _send(template.build());
  }

  Future<AiResponse> _send(String prompt) async {
    if (config.apiKey.trim().isEmpty) {
      return const AiResponse(
        text: "",
        error: "API key is missing. Please configure your AI API key.",
      );
    }

    try {
      final res = await http.post(
        Uri.parse('${config.baseUrl}/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${config.apiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": config.model,
          "messages": [
            {"role": "user", "content": prompt}
          ],
        }),
      );


      if (res.statusCode != 200) {
        return AiResponse(
          text: "",
          error:
              "AI request failed (${res.statusCode}). Please check your API key or network.",
        );
      }


      final Map<String, dynamic> data = jsonDecode(res.body);

      final choices = data["choices"];
      if (choices == null || choices is! List || choices.isEmpty) {
        return const AiResponse(
          text: "",
          error: "Invalid response received from AI service.",
        );
      }

      final content = choices[0]["message"]?["content"];
      if (content == null || content is! String) {
        return const AiResponse(
          text: "",
          error: "AI response content is empty or malformed.",
        );
      }


      return AiResponse(
        text: content,
        tokens: data["usage"]?["total_tokens"],
      );
    } catch (e) {
      return AiResponse(
        text: "",
        error: "AI request error: ${e.toString()}",
      );
    }
  }
}
