class Validation {
  // FULL NAME VALIDATION RULES
  String? validateFname(String? value) {
    if (value == null || value.isEmpty) {
      return "Full Name is Required";
    }
    final hasNums = RegExp(r'[0-9]').hasMatch(value);
    if (hasNums) {
      return "Name does not contain Numbers";
    }
    return null;
  }

  // EMAIL VALIDATION RULES
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is Required";
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid Email";
    }

    return null;
  }

  // MOBILE NUMBER VALIDATION RULES
  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile Number is Required";
    }
    if (value.length != 11) {
      return "Mobile Number should be 11 Digits";
    }
    return null;
  }

  // PASSWORD VALIDATION RULES
  String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is Required";
    }
    if (value.length < 8) {
      return "Password must be 8 Characters Long";
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain 1 UpperCase Letter";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain atleast 1 Number";
    }
    return null;
  }

  // CONFIRM PASSWORD VALIDATION RULES
  String? validateConfirmPass(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is Required";
    } else if (value != password) {
      return "Passwords do not Match";
    }
    return null;
  }

  // LOGIN PASSWORD VALIDATION RULES
  String? validateLoginPass(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is Required";
    }
    return null;
  }

  // CONTACT MESSAGE VALIDATION RULES
  String? validateMsg(String? value) {
    if (value == null || value.isEmpty) {
      return "Message should not be Empty";
    }
    return null;
  }
}
