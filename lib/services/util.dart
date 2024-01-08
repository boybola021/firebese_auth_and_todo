


sealed class Util {
  static bool regexName(String text) => RegExp("^[a-z A-Z]{4,}").hasMatch(text.trim());

  static bool regexEmail(String email) =>  RegExp(r"[a-z A-Z 0-9]{4,}@gmail.com$").hasMatch(email.trim());

  static bool regexPassword(String password) => RegExp(r"[a-z A-Z 0-9]{6,}").hasMatch(password.trim());

  static bool validateRegistration(
      String username, String email, String password, String prePassword) {

    if (
    RegExp(r"^[a-z A-Z]{4,}").hasMatch(username.trim()) &&
        RegExp(r"[a-z A-Z 0-9]{4,}@gmail\.com$").hasMatch(email.trim()) &&
        RegExp(r"[a-z A-Z 0-9]{6,}").hasMatch(password.trim()) &&
        password.trim() == prePassword.trim()
    ) {
      return true;
    }
    return false;
  }
}