String? emailValidate(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "Champs obligatoire";
  } else if (!regex.hasMatch(value!)) {
    return "Vérifiez votre email";
  } else {
    return null;
  }
}

String? nameValidate(String? value) {
  if (value?.isEmpty ?? true) {
    return "Champs obligatoire";
  } else if (value!.length < 3) {
    return "Vérifiez votre nom";
  } else {
    return null;
  }
}
