// data_helper.dart

List<String> filterUniqueTopics(List<dynamic> jsonData) {
  final Set<String> uniqueMainTopics = {};
  return jsonData
      .where((item) => item['topic_name'] != null && item['quiz_type'] == 'notes')
      .map((item) {
    // Extract the main topic name before ">>" and normalize it
    final mainTopic = (item['topic_name'] as String).split('>>')[0].trim();
    return mainTopic;
  })
      .where((mainTopic) => uniqueMainTopics.add(mainTopic)) // Only add unique topics
      .toList();
}
