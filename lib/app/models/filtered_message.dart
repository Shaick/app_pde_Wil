class FilteredMessage {
  final String text;
  final String rawText;
  final bool hasNumber;
  final int numberCount;
  final DateTime timeMessage;

  const FilteredMessage({
    required this.rawText,
    required this.text,
    required this.hasNumber,
    required this.numberCount,
    required this.timeMessage,
  });

  bool get isBad => text != rawText;
}
