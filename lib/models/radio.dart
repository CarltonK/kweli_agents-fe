class RadioModel {
  int? value;
  String? title;

  RadioModel({this.value, this.title});
}

RadioModel male = RadioModel(value: 0, title: 'Male');
RadioModel female = RadioModel(value: 1, title: 'Female');
RadioModel shortTerm = RadioModel(value: 0, title: '1 - 2 months');
RadioModel mediumTerm = RadioModel(value: 1, title: '3 - 5 months');
RadioModel longTerm = RadioModel(value: 2, title: '6 - 8 months');
RadioModel veryLongTerm = RadioModel(value: 3, title: '>12months');

List<RadioModel> genderOptions = [male, female];
List<RadioModel> durationOptions = [
  shortTerm,
  mediumTerm,
  longTerm,
  veryLongTerm
];
