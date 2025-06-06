String toTitleCase(String text) {
  if (text == null || text.isEmpty) {
    return '';
  }

  String processedText = text.replaceAll('_', ' ');

  // Split the string by spaces
  List<String> words = processedText.split(' ');

  // Capitalize the first letter of each word and make the rest lowercase
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) {
      return '';
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();

  // Join the words back together with spaces
  return capitalizedWords.join(' ');
}
