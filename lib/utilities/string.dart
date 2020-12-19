extension StringMethod on String {
  bool isNullOrEmpty() {
    if (this == null || isEmpty) {
      return true;
    }
    return false;
  }

  bool isPhone(){
    /// Check sim đầu 09 10 số, đầu 02 11 số, chỉ nhập số nguyên
    final phoneRegex = RegExp(r'^(09|08|07|05|03|02[0-9])+([0-9]{8})$');

    if (phoneRegex.hasMatch(this.replaceAll('.', ''))) {
      return true;
    }
    return false;
  }
}

String getCharacter(int index) {
  final alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  if (index < alphabet.length) {
    return alphabet[index];
  }
  return "";
}
