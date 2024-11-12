class TgUserModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String languageCode;
  final bool allowsWriteToPm;
  final String chatInstance;
  final String chatType;
  final String hash;

  TgUserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.languageCode,
    required this.allowsWriteToPm,
    required this.chatInstance,
    required this.chatType,
    required this.hash,
  });

  // Method to convert model to a map (for storage, APIs, etc.)
  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'first_name': firstName,
      'last_name': lastName,
      'language_code': languageCode,
      'allows_write_to_pm': allowsWriteToPm,
      'chat_instance': chatInstance,
      'chat_type': chatType,
      'hash': hash,
    };
  }

  // Method to create model from a map (for retrieving from storage, APIs, etc.)
  static TgUserModel fromMap(Map<String, dynamic> map) {
    var userMap = map['user']; // Extract the 'user' object from the main map
    return TgUserModel(
      id: userMap['id'].toString(),
      firstName: userMap['first_name'].toString(),
      lastName: userMap['last_name'] != null ? userMap['last_name'].toString() : null,
      languageCode: userMap['language_code'].toString(),
      allowsWriteToPm: userMap['allows_write_to_pm'] == true,
      chatInstance: map['chat_instance'].toString(),
      chatType: map['chat_type'].toString(),
      hash: map['hash'].toString(),
    );
  }
}