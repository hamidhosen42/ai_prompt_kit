class PromptTemplate {
  final String template;
  final Map<String, String> variables;

  PromptTemplate({
    required this.template,
    required this.variables,
  });

  String build() {
    var output = template;
    for (final entry in variables.entries) {
      output = output.replaceAll('{${entry.key}}', entry.value);
    }
    return output;
  }
}