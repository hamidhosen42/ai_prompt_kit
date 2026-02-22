import 'package:flutter/material.dart';
import 'package:ai_prompt_kit/ai_prompt_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const PromptTemplateDemo(),
    );
  }
}

class PromptTemplateDemo extends StatefulWidget {
  const PromptTemplateDemo({super.key});

  @override
  State<PromptTemplateDemo> createState() => _PromptTemplateDemoState();
}

class _PromptTemplateDemoState extends State<PromptTemplateDemo> {
  final textController = TextEditingController(
    text:
    "Flutter packages help developers share reusable components and speed up app development.",
  );

  String result = "AI response will appear here.";
  bool isLoading = false;
  bool isError = false;
  int? tokens;

  Future<void> _runPromptTemplate() async {
    final apiKey = "";

    if (apiKey.isEmpty) {
      setState(() {
        isError = true;
        result = "API key not configured. Please check your .env file.";
      });
      return;
    }

    if (textController.text.trim().isEmpty) {
      setState(() {
        isError = true;
        result = "Please enter some text.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      isError = false;
      tokens = null;
    });

    final client = AiClient(
      AiConfig(
        apiKey: apiKey,
        baseUrl: "https://api.openai.com/v1",
      ),
    );

    final prompt = PromptTemplate(
      template: "Summarize the following text:\n{text}",
      variables: {
        "text": textController.text,
      },
      language: AiLanguage.chinese,
    );

    final response = await client.run(prompt);

    setState(() {
      isLoading = false;
      isError = response.hasError;
      result = response.hasError ? response.error! : response.text;
      tokens = response.tokens;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PromptTemplate Demo"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // ? Input Field
              TextField(
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Input Text",
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ? Button
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                  onPressed: isLoading ? null : _runPromptTemplate,
                  icon: const Icon(Icons.auto_fix_high),
                  label: Text(
                    isLoading ? "Processing..." : "Run PromptTemplate",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ? Result Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: isLoading
                    ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: isError
                            ? Colors.redAccent
                            : Colors.black87,
                      ),
                    ),
                    if (tokens != null) ...[
                      const SizedBox(height: 15),
                      Text(
                        "Tokens used: $tokens",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}