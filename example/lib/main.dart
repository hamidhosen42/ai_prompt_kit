import 'package:flutter/material.dart';
import 'package:ai_prompt_kit/ai_prompt_kit.dart';

void main() {
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
  static const String apiKey = ""; 

  final textController = TextEditingController(
    text:
        "Flutter packages help developers share reusable components and speed up app development.",
  );

  String result = "AI response will appear here.";
  bool isLoading = false;
  bool isError = false;

  Future<void> _runPromptTemplate() async {
    if (apiKey.isEmpty) {
      setState(() {
        isError = true;
        result = "API key not configured. Please add your AI API key.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      isError = false;
    });

    final client = AiClient(
      AiConfig(
        apiKey: apiKey,
        baseUrl: "https://api.openai.com/v1",
      ),
    );


    final prompt = PromptTemplate(
      template: "Summarize the following text in {lang}:\n{text}",
      variables: {
        "lang": "English",
        "text": textController.text,
      },
    );

    final response = await client.run(prompt);

    setState(() {
      isLoading = false;
      isError = response.hasError;
      result = response.hasError ? response.error! : response.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PromptTemplate Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: textController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Input Text",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),


            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : _runPromptTemplate,
                icon: const Icon(Icons.auto_fix_high),
                label: const Text("Run PromptTemplate"),
              ),
            ),

            const SizedBox(height: 16),


            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Text(
                            result,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: isError
                                  ? Colors.redAccent
                                  : Colors.black87,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
