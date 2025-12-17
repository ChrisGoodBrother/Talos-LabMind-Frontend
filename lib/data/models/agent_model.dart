class AgentModel {
  final String name;
  final String message;
  final String description;
  final String? terminationMessage;

  AgentModel({
    required this.name,
    required this.message,
    required this.description,
    this.terminationMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "message": message,
      "description": description,
      "terminationMessage": terminationMessage,
    };
  }
}