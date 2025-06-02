// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return 'Total Daily Calories: $totalCalories';
  }

  @override
  String get clearListWarningTitle => 'Really CLEAR the List?';

  @override
  String get clearListWarningBody => 'This will delete ALL of today\'s items';

  @override
  String get calorieEntryHistoryTitle => 'Calorie Entry History';

  @override
  String get calorieTrackingSubmenuTitle => 'Progress Tracking Options';

  @override
  String get calendarMenuItem => 'Calendar';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return 'Total Calories: $totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return 'Your first entry was on $date';
  }

  @override
  String get emptyHistoryMsg => 'You have no entries in your history yet';

  @override
  String get chartsMenuItem => 'Charts';

  @override
  String get showAverageLabel => 'Show Average';

  @override
  String get excludeTodayLabel => 'Exclude Today';

  @override
  String get dateRangeLabel => 'Date Range';

  @override
  String get dateRage7Days => 'Past 7 Days';

  @override
  String get dateRange30Days => 'Past 30 Days';

  @override
  String get dateRangeMax => 'Max';

  @override
  String get caloriesGoalPlanLabel => 'Calories Goal Plan';

  @override
  String get caloriesGoalPlanNone => 'None';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => 'Custom';

  @override
  String get maintenanceCaloriesChartLabel => 'Maintenance Calories';

  @override
  String get daysCaloriesChartLabel => 'Day\'s Calories';

  @override
  String get rangeAverageChartLabel => 'Range Average';

  @override
  String get yourPlanMenuItem => 'Your Plan';

  @override
  String get metricOption => 'Metric';

  @override
  String get imperialOption => 'Imperial';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get weightLbs => 'Weight (lbs)';

  @override
  String get heightMetric => 'Height (cm)';

  @override
  String get heightFeet => 'Height (ft)';

  @override
  String get heightInches => 'Height (in)';

  @override
  String get age => 'Age';

  @override
  String get activityLevelLabel => 'Your activity level';

  @override
  String get activityLevelBedridden => 'Bedridden';

  @override
  String get activityLevelSedentary => 'Sedentary';

  @override
  String get activityLevelLight => 'Light/1-3 Days Per Week';

  @override
  String get activityLevelModerate => 'Moderate/3-5 Days Per Week';

  @override
  String get activityLevelHard => 'Hard Exercise/6-7 Days Per Week';

  @override
  String get activityLevelExtreme => 'Extremely Active/Sports and Physical Job';

  @override
  String get calculateButtonLabel => 'Calculate';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return 'Estimated Daily Calorie Needs: $calories';
  }

  @override
  String get customGoalPlanPrompt => 'Enter your daily calories target';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get faqLabel => 'FAQ';

  @override
  String get tipsLabel => 'Tips and How Tos';

  @override
  String get themeLabel => 'App Theme';

  @override
  String get exportImportLabel => 'Export/Import Data';

  @override
  String get supportLabel => 'Support the Developer';

  @override
  String get faqMarkdown =>
      '# FAQ\n---\n## Usable Math Symbols for entries\n- +, -, x and *, / for mathematical operations\n- , (comma) to separate items within an entry  \n  \\(this is semantically equivalent to addition\\)\n\n---\n\n## Optional Notes on Entries\nYou may label additional information, such as the name of the food logged or whatever else you would like in a comment\nby adding a : (colon) to your entry and adding your comment after, such as\\\\\n**100+80+50: egg and toast w/ jam**\n\n---\n\n';

  @override
  String get tipsMarkdown =>
      '# Tips and How Tos\n---\n## How to Calculate Partial Servings\nPartial Servings can be entered as:\n\ncalories-per-serving x amount / amount-per-serving\n\nSo if you had cereal that was measured in 60 gram servings, you ate 90 grams of it, and the\namount of calories per serving is 200, The total calories can be entered as:\\\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => 'Change App Theme';

  @override
  String get lightLabel => 'Light';

  @override
  String get darkLabel => 'Dark';

  @override
  String get systemLabel => 'System';

  @override
  String get exportImportDataTitle => 'Import/Export Calorie Data';

  @override
  String get exportImportText1 =>
      'You can convert your entry data to a CSV, saved locally. Ensure that you back up data before overwriting.';

  @override
  String get exportImportText2 =>
      'For export, this app requires you allow it to write to external storage as it is a .csv file and will ask for permission to do so';

  @override
  String get exportImportText3 =>
      'The resulting file may be opened in Excel or any other program that accepts CSVs, as well as be used to import and overwrite data in this app.';

  @override
  String get exportImportExportLabel => 'Export';

  @override
  String get exportImportImportLabel => 'Import';

  @override
  String get exportImportSavingMsg => 'saving file...';

  @override
  String exportImportSavedFileMsg(String path) {
    return 'Saved file to $path';
  }

  @override
  String get exportImportFailureMsg => 'Export unsuccessful.';

  @override
  String get exportImportOverwriteWarningHeader => 'Really OVERWRITE all data?';

  @override
  String get exportImportOverwriteWarningBody =>
      'This will clear all previous content. Ensure you have made a backup of your current data with \'Export\' before proceeding';

  @override
  String get exportImportOverwriteWarning2Header => 'Are you sure?';

  @override
  String get exportImportOverwriteWarning2Body =>
      'Ensure you have backed up your data with \'Export\'. You cannot recover your initial data after.';

  @override
  String get exportImportOverwriteConfirm => 'Confirm Overwrite';

  @override
  String get exportImportDataMalformedErrorMsg =>
      'Data was malformed, not all rows were length 3';

  @override
  String get supportTitle => 'Support the Developer';

  @override
  String get supportBody =>
      'If this app has helped you achieve your goals, or you appreciate it over other apps available to you, or whatever the reason, consider supporting me by sending me a tip on the ko-fi link below.';

  @override
  String versionLabel(String versionNumber) {
    return 'version number: $versionNumber';
  }

  @override
  String get continueButton => 'Continue';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get loadingText => 'Loading...';

  @override
  String get editCaloriesCalendarButton => 'Edit';
}
