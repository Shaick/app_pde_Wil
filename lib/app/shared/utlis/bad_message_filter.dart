import 'package:app_pde/app/models/filtered_message.dart';
import 'package:app_pde/app/shared/utlis/bad_words.dart';

class BadMessageFilter {
  static FilteredMessage filter(String rawText, DateTime dateTime) {
    int numberCount = 0;
    String _regExp =
        "[(][0-9]{2}[)][0-9]{9}|[(][0-9]{2}[)][0-9]{8}|[(][0-9]{2}[)][0-9]{5}[-][0-9]{4}|[(][0-9]{2}[)][0-9]{4}[-][0-9]{4}|[0-9]{2}[ ][0-9]{9}|[0-9]{2}[ ][0-9]{8}|[0-9]{2}[ ][0-9]{5}[-][0-9]{4}|[0-9]{2}[ ][0-9]{4}[-][0-9]{4}|[0-9]{11}|[0-9]{10}|[0-9]{9}|[0-9]{8}";

    final numberFreeText = rawText.replaceAll(RegExp(_regExp), '** *********');
    numberCount = '*'.allMatches(numberFreeText).length;
    final wordList = numberFreeText.toLowerCase().split(' ');
    final filteredText = wordList.map((word) {
      if (badWords.contains(word)) {
        return '*' * word.length;
      } else {
        return word;
      }
    }).join(' ');

    return FilteredMessage(
      rawText: rawText,
      text: filteredText,
      hasNumber: numberCount > 0,
      numberCount: numberCount,
      timeMessage: dateTime,
    );
  }
}
