class Permission {
  final String module;
  final List<String> action;

  Permission({
    required this.module,
    required this.action,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      module: json['module'],
      action: List<String>.from(json['action']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'module': module,
      'action': action,
    };
  }
}