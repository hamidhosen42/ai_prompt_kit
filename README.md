# ai_prompt_kit 🤖✨

A Flutter-friendly AI helper package for calling LLM / AI APIs using **prompt templates**, clean abstractions, and safe response handling.

This package is designed to make AI integration in Flutter **simple, readable, and production-ready**.

------------------------------------------------------------------------

## ✨ Features

-   🔌 OpenAI-compatible REST API support\
-   🧠 `PromptTemplate` system (variable-based prompts)\
-   🌍 Multi-language support via `AiLanguage`
-   🔎 Auto language detection\
-   📊 Token usage tracking\
-   ⚠️ Graceful error handling (no crashes)\
-   🎯 UI-agnostic\
-   🚀 Production-ready example app

------------------------------------------------------------------------

## 📦 Installation

Add to your `pubspec.yaml`:

``` yaml
dependencies:
  ai_prompt_kit: ^0.1.0
```

Then run:

``` bash
flutter pub get
```

------------------------------------------------------------------------

# 🚀 Quick Start

## 1️⃣ Initialize the AI Client

``` dart
final aiClient = AiClient(
  AiConfig(
    apiKey: "YOUR_API_KEY",
    baseUrl: "https://api.openai.com/v1",
  ),
);
```

> ⚠️ Never hardcode API keys in production apps.\
> Use environment variables or a backend proxy.

------------------------------------------------------------------------

# 🧠 Using PromptTemplate

``` dart
final prompt = PromptTemplate(
  template: "Summarize the following text:\n{text}",
  variables: {
    "text": "Flutter packages help developers share reusable components.",
  },
  language: AiLanguage.chinese,
);

final response = await aiClient.run(prompt);

if (response.hasError) {
  print(response.error);
} else {
  print(response.text);
  print("Tokens used: ${response.tokens}");
}
```

------------------------------------------------------------------------

# 🌍 Language Control

Force response language:

``` dart
language: AiLanguage.bengali
language: AiLanguage.chinese
language: AiLanguage.arabic
```

Enable automatic detection:

``` dart
await aiClient.complete(
  prompt: userInput,
  autoDetectLanguage: true,
);
```

------------------------------------------------------------------------

# 📊 AI Response Model

``` dart
class AiResponse {
  final String text;
  final int? tokens;
  final String? error;

  bool get hasError => error != null;
}
```

------------------------------------------------------------------------

# ⚠️ Error Handling

Handled scenarios:

-   Missing API key\
-   Invalid API key (401)\
-   Network failures\
-   Invalid AI response\
-   Unexpected API errors

------------------------------------------------------------------------

# 🔐 Security Best Practice

Recommended architecture:

Flutter App → Your Backend → OpenAI

Instead of:

Flutter App → OpenAI directly

------------------------------------------------------------------------

# 🛣️ Roadmap

-   🌊 Streaming responses\
-   🧾 Structured JSON output mode\
-   🧠 System + User role messaging\
-   🔄 Multi-provider support\
-   📦 Built-in AI presets

------------------------------------------------------------------------

## 👨‍💻 Project Maintainer ❤️

[![Md. Hamid Hosen](https://github.com/hamidhosen42.png?size=140)](https://github.com/hamidhosen42)

**[Md. Hamid Hosen](https://github.com/hamidhosen42)**  
Associate Software Engineer @P2M Soft

------------------------------------------------------------------------

# 📄 License

MIT License