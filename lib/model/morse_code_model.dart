class MorseCodeModel {
  String? id;
  dynamic date;
  String? letters;
  String? morseCode;

  MorseCodeModel({
    this.id,
    this.date, 
    this.letters, 
    this.morseCode,
  });

  factory MorseCodeModel.fromJson(Map<String, dynamic> json) {
    return MorseCodeModel(
      id: json['id'],
      date: json['date'],
      letters: json['letters'],
      morseCode: json['morse_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'letters': letters,
      'morse_code': morseCode,
    };
  }
}
