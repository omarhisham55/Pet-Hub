class MainStrings {
  static const String title = 'Paw Buddy';
  static const String undefinedRoute = 'undefined route';
  static const String retry = 'Retry';
  static const String continueString = 'Continue';
}

class OnBoardingStrings {
  static const String boardingTitle = 'Personalized Pet Profiles';
  static const String boardingcontent =
      'Create personalized profiles for each of your beloved pets on PawBuddy. Share their name, breed, and age while connecting with a vibrant community.';
}

class RegistrationStrings {
  static const String createAccount = 'Create Account';
  static const String getStarted = 'Get started';
  static const String welcome =
      'Welcome! Please enter your information below and get started.';
  static const String emailHintText = 'Your email';
  static const String passwordHintText = 'Password';
  static const String emailValidatorText = 'Enter valid email';
  static const String passwordValidatorText =
      'Enter valid password: min 6 chars';
  static const String validationTitle = 'Validation Code';
  static const String validationContent =
      'Check your email inbox and enter the validation code here';
  static const String termsAndConditions = 'Accept Terms and Conditions';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String loginHere = 'Login here!';
}

class ErrorStrings {
  //! App Errors
  static const String failedToCreateUser =
      "Failed to create account, try again!";
  static const String failedToUpdateUser = "Failed to update info, try again!";
  static const String emptyList = "List is empty or not found!";
  static const String noInternetConnection =
      "No Internet Connection, please connect to the internet!";

  //! Firebase Errors
  static const String unknown = "An unknown error occurred.";
  static const String invalidCredential = "Email or password is incorrect.";
  static const String invalidEmail = "The email address is invalid.";
  static const String userDisabled = "The user account is disabled.";
  static const String userNotFound = "The email address is invalid.";
  static const String wrongPassword = "Incorrect password. Please try again.";
  static const String emailAlreadyInUse = "This email is already in use.";
  static const String operationNotAllowed = "This operation is not allowed.";
  static const String weakPassword = "The password is too weak.";
  static const String cancelled = "The operation was cancelled.";
  static const String permissionDenied =
      "You don't have permission for this action.";
  static const String notFound = "The requested resource was not found.";
  static const String alreadyExists = "The document already exists.";
  static const String deadlineExceeded = "The operation took too long.";
  static const String resourceExhausted = "Resource limit exceeded.";
  static const String invalidArgument =
      "Invalid argument provided to Firestore operation.";
  static const String failedPrecondition =
      "Operation cannot be executed in the current state.";
  static const String aborted = "The operation was aborted due to a conflict.";
  static const String outOfRange =
      "The provided value is out of the acceptable range.";
  static const String unimplemented =
      "The requested operation is not implemented.";
  static const String internal = "An internal error occurred within Firestore.";
  static const String unavailable =
      "Firestore service is currently unavailable.";
  static const String dataLoss =
      "Data loss or corruption detected in Firestore.";
}
