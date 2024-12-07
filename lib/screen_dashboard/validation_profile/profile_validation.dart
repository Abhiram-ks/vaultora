class AgeValidatorField {
  static String? validate(String? age) {
    if (age == null || age.isEmpty) {
      return 'Please Enter Age';
    }
    final int? ageValue = int.tryParse(age);
    if (ageValue == null || ageValue < 18 || ageValue > 120) {
      return 'Age must be between 18 and 120';
    }
    return null;
  }
}


class BioValidatorField {
  static String? validate(String? bio) {
    if (bio == null || bio.isEmpty) {
      return 'Please Enter bio';
    }
    if (bio.length > 120) {
      return 'Bio must not exceed 250 characters';
    }
    return null;
  }
}
