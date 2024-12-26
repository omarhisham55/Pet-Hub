import 'package:flutter/material.dart';

class MainStrings {
  static const String title = 'Paw Buddy';
  static const String undefinedRoute = 'undefined route';
  static const String retry = 'Retry';
  static const String edit = 'Edit';
  static const String submit = 'Submit';
  static const String continueString = 'Continue';
  static const String kg = 'Kg';
  static const String lbs = 'lbs';
  static const String male = 'Male';
  static const String female = 'Female';
  static const String seeMore = 'See more';
  static String ageYears(bool past) => past ? 'years ago' : 'yeard old';
  static String ageMonths(bool past) => past ? 'months ago' : 'months';
  static String ageDays(bool past) => past ? 'days ago' : 'days';

  //? navbar strings
  static const Map<String, IconData> bottomNavbarItems = {
    'Home': Icons.pets_outlined,
    'Health': Icons.health_and_safety_outlined,
    'Appointments': Icons.app_registration_outlined,
    'Store': Icons.store_mall_directory_outlined,
  };

  //? onboarding strings
  static const String boardingTitle = 'Personalized Pet Profiles';
  static const String boardingcontent =
      'Create personalized profiles for each of your beloved pets on PawBuddy. Share their name, breed, and age while connecting with a vibrant community.';

  //? registration strings
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

  static const String addProfile = 'Add profile';
  static const String addToAccount = 'Add to account';
  static const String addPetProfile = 'Add Pet Profile';
  static const String petAdded = 'Your pet is added';
  static const String step = 'Step';
  static const String category = 'Category';
  static const String breed = 'Breed';
  static const String name = 'Name';
  static const String size = 'Size';
  static const String weight = 'Weight';
  static const String gender = 'Gender';
  static const String importantDates = 'Important dates';
  static const String caretakers = 'Caretakers';
  static const String addPetCategoryHint = 'Search by pet category';
  static const String addPetBreedHint = 'Search by breed';
  static const String addPetNameTitle = 'What\'s your pet\'s name';
  static const String addPetNameSubtitle = 'Adding image is optional for now';
  static const String addPetNameHint = 'Your pet\'s name';
  static const String addPetSizeTitle = 'What\'s your pet\'s size';
  static const String addPetSizeSubtitle =
      'Automatic selection based on your pet\'s breed. Adjust according to reality.';
  static const Map<String, String> sizeInfo = {
    'Small': 'under 14kg',
    'Medium': '14-25kg',
    'Large': 'over 24kg',
  };
  static const String addPetWeightTitle = 'What\'s your pet\'s weight?';
  static const String addPetWeightSubtitle =
      'Automatic selection based on your pet\'s breed. Adjust according to reality.';
  static const String addPetImportantDatesTitle = 'Time to celebrate';
  static const String birthday = 'Birthday';
  static const String adoptionDay = 'Adoption day';

//? profile strings
  static const String petDetailsTitle = 'Appearance and distinctive signs';
  static String hello(String name) => 'Hello,$name';
  static const String userEmptyPets =
      'Uh Oh!\nLooks like you have no profiles set up at this moment, add your pet now';
  static const String activePetProfile = 'Active pet profile';

  //? store strings
  static const String noCategories =
      'An error happened while fetching categories';
  static const String emptyProductsFilteredByCategry =
      'No products for this category!';
  static const String productDetailAppbarTitle = 'Product details';
  static const String similarProductsTitle = 'Similar Products';
  static const String noSimilarProducts = 'No similar products found';
  static const String commentReviewsTitle = 'Comments & Reviews';
  static const String addCommentHint = 'Add your comment...';
  static const String ratingDialogTitle = 'This comment requires a rating';
  static const String commentAdded = 'Comment added';
  static const String emptyComments =
      'No comments found for this product!\nBe the first to comment.';
  static const String addToCart = 'Add to cart';

  //? drawer strings
  static const String drawerYourPets = 'Your Pets';
  static const String drawerAddNew = 'add new';
  static const Map<String, IconData> drawerTitles = {
    'Dashboard': Icons.dashboard_customize_outlined,
    'Contacts': Icons.contacts_outlined,
    'Calendar': Icons.calendar_today_outlined,
    'Account': Icons.person_outline,
    'Settings': Icons.settings_outlined,
  };

//? dialog strings
  static const String cancel = 'Cancel';
  static const String yes = 'Yes';
  static const String addPetExitDialogTitle = 'Are you sure you want to exit?';
  static const String addPetExitDialogContent = 'All data will be lost!';
}

class ErrorStrings {
  //! App Errors
  static const String failedToCreateUser =
      "Failed to create account, try again!";
  static const String failedToUpdateUser = "Failed to update info, try again!";
  static const String emptyList = "List is empty or not found!";
  static const String addPetEmptyNameError = "Pet name required!";

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
