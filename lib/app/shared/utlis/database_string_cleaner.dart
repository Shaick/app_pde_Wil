class DatabaseStringCleaner {
  static String cleanPhoneNumber(String input) {
    return input
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(' ', '');
  }
}

