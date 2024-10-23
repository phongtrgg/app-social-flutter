class GroupRequest {
  final String? groupName;
  final String? description;
  final bool? isPrivate;

  GroupRequest({this.groupName, this.description, this.isPrivate});

  factory GroupRequest.fromJson(Map<String, dynamic> json) {
    return GroupRequest(
      groupName: json['groupName'] as String?,
      description: json['description'] as String?,
      isPrivate: json['private'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'description': description,
      'private': isPrivate,
    };
  }
}
