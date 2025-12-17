class Agent {
  final String name;
  final String message;
  final String description;
  final String? terminationMessage;

  Agent({
    required this.name,
    required this.message,
    required this.description,
    this.terminationMessage,
  });
}