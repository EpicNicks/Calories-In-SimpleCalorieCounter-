import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('it'),
    Locale('ja'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW')
  ];

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @dailyCalorieTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Daily Calories: {totalCalories}'**
  String dailyCalorieTotal(int totalCalories);

  /// No description provided for @clearListWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Really CLEAR the List?'**
  String get clearListWarningTitle;

  /// No description provided for @clearListWarningBody.
  ///
  /// In en, this message translates to:
  /// **'This will delete ALL of today\'s items'**
  String get clearListWarningBody;

  /// No description provided for @calorieEntryHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie Entry History'**
  String get calorieEntryHistoryTitle;

  /// No description provided for @calorieTrackingSubmenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking Options'**
  String get calorieTrackingSubmenuTitle;

  /// No description provided for @calendarMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarMenuItem;

  /// No description provided for @caloriesTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Calories: {totalCalories}'**
  String caloriesTotalLabel(int totalCalories);

  /// No description provided for @yourFirstEntryText.
  ///
  /// In en, this message translates to:
  /// **'Your first entry was on {date}'**
  String yourFirstEntryText(String date);

  /// No description provided for @emptyHistoryMsg.
  ///
  /// In en, this message translates to:
  /// **'You have no entries in your history yet'**
  String get emptyHistoryMsg;

  /// No description provided for @chartsMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get chartsMenuItem;

  /// No description provided for @showAverageLabel.
  ///
  /// In en, this message translates to:
  /// **'Show Average'**
  String get showAverageLabel;

  /// No description provided for @excludeTodayLabel.
  ///
  /// In en, this message translates to:
  /// **'Exclude Today'**
  String get excludeTodayLabel;

  /// No description provided for @dateRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRangeLabel;

  /// No description provided for @dateRage7Days.
  ///
  /// In en, this message translates to:
  /// **'Past 7 Days'**
  String get dateRage7Days;

  /// No description provided for @dateRange30Days.
  ///
  /// In en, this message translates to:
  /// **'Past 30 Days'**
  String get dateRange30Days;

  /// No description provided for @dateRangeMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get dateRangeMax;

  /// No description provided for @caloriesGoalPlanLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories Goal Plan'**
  String get caloriesGoalPlanLabel;

  /// No description provided for @caloriesGoalPlanNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get caloriesGoalPlanNone;

  /// No description provided for @caloriesGoalPlanMSJ.
  ///
  /// In en, this message translates to:
  /// **'Mifflin-St Jeor'**
  String get caloriesGoalPlanMSJ;

  /// No description provided for @caloriesGoalPlanCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get caloriesGoalPlanCustom;

  /// No description provided for @maintenanceCaloriesChartLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Calories'**
  String get maintenanceCaloriesChartLabel;

  /// No description provided for @daysCaloriesChartLabel.
  ///
  /// In en, this message translates to:
  /// **'Day\'s Calories'**
  String get daysCaloriesChartLabel;

  /// No description provided for @rangeAverageChartLabel.
  ///
  /// In en, this message translates to:
  /// **'Range Average'**
  String get rangeAverageChartLabel;

  /// No description provided for @yourPlanMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Your Plan'**
  String get yourPlanMenuItem;

  /// No description provided for @metricOption.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metricOption;

  /// No description provided for @imperialOption.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get imperialOption;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// No description provided for @weightLbs.
  ///
  /// In en, this message translates to:
  /// **'Weight (lbs)'**
  String get weightLbs;

  /// No description provided for @heightMetric.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightMetric;

  /// No description provided for @heightFeet.
  ///
  /// In en, this message translates to:
  /// **'Height (ft)'**
  String get heightFeet;

  /// No description provided for @heightInches.
  ///
  /// In en, this message translates to:
  /// **'Height (in)'**
  String get heightInches;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @activityLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Your activity level'**
  String get activityLevelLabel;

  /// No description provided for @activityLevelBedridden.
  ///
  /// In en, this message translates to:
  /// **'Bedridden'**
  String get activityLevelBedridden;

  /// No description provided for @activityLevelSedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get activityLevelSedentary;

  /// No description provided for @activityLevelLight.
  ///
  /// In en, this message translates to:
  /// **'Light/1-3 Days Per Week'**
  String get activityLevelLight;

  /// No description provided for @activityLevelModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate/3-5 Days Per Week'**
  String get activityLevelModerate;

  /// No description provided for @activityLevelHard.
  ///
  /// In en, this message translates to:
  /// **'Hard Exercise/6-7 Days Per Week'**
  String get activityLevelHard;

  /// No description provided for @activityLevelExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extremely Active/Sports and Physical Job'**
  String get activityLevelExtreme;

  /// No description provided for @calculateButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculateButtonLabel;

  /// No description provided for @estimatedDailyNeedsLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated Daily Calorie Needs: {calories}'**
  String estimatedDailyNeedsLabel(int calories);

  /// No description provided for @customGoalPlanPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your daily calories target'**
  String get customGoalPlanPrompt;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @faqLabel.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqLabel;

  /// No description provided for @tipsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tips and How Tos'**
  String get tipsLabel;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get themeLabel;

  /// No description provided for @exportImportLabel.
  ///
  /// In en, this message translates to:
  /// **'Export/Import Data'**
  String get exportImportLabel;

  /// No description provided for @supportLabel.
  ///
  /// In en, this message translates to:
  /// **'Support the Developer'**
  String get supportLabel;

  /// No description provided for @faqMarkdown.
  ///
  /// In en, this message translates to:
  /// **'# FAQ\n---\n## Usable Math Symbols for entries\n- +, -, x and *, / for mathematical operations\n- , (comma) to separate items within an entry  \n  \\(this is semantically equivalent to addition\\)\n\n---\n\n## Optional Notes on Entries\nYou may label additional information, such as the name of the food logged or whatever else you would like in a comment\nby adding a : (colon) to your entry and adding your comment after, such as\\\\\n**100+80+50: egg and toast w/ jam**\n\n---\n\n'**
  String get faqMarkdown;

  /// No description provided for @tipsMarkdown.
  ///
  /// In en, this message translates to:
  /// **'# Tips and How Tos\n---\n## How to Calculate Partial Servings\nPartial Servings can be entered as:\n\ncalories-per-serving x amount / amount-per-serving\n\nSo if you had cereal that was measured in 60 gram servings, you ate 90 grams of it, and the\namount of calories per serving is 200, The total calories can be entered as:\\\n**200 x 90 / 60** ***(=300)***\n\n---\n'**
  String get tipsMarkdown;

  /// No description provided for @appThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change App Theme'**
  String get appThemeTitle;

  /// No description provided for @lightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightLabel;

  /// No description provided for @darkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkLabel;

  /// No description provided for @systemLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemLabel;

  /// No description provided for @exportImportDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Import/Export Calorie Data'**
  String get exportImportDataTitle;

  /// No description provided for @exportImportText1.
  ///
  /// In en, this message translates to:
  /// **'You can convert your entry data to a CSV, saved locally. Ensure that you back up data before overwriting.'**
  String get exportImportText1;

  /// No description provided for @exportImportText2.
  ///
  /// In en, this message translates to:
  /// **'For export, this app requires you allow it to write to external storage as it is a .csv file and will ask for permission to do so'**
  String get exportImportText2;

  /// No description provided for @exportImportText3.
  ///
  /// In en, this message translates to:
  /// **'The resulting file may be opened in Excel or any other program that accepts CSVs, as well as be used to import and overwrite data in this app.'**
  String get exportImportText3;

  /// No description provided for @exportImportExportLabel.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportImportExportLabel;

  /// No description provided for @exportImportImportLabel.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get exportImportImportLabel;

  /// No description provided for @exportImportSavingMsg.
  ///
  /// In en, this message translates to:
  /// **'saving file...'**
  String get exportImportSavingMsg;

  /// No description provided for @exportImportSavedFileMsg.
  ///
  /// In en, this message translates to:
  /// **'Saved file to {path}'**
  String exportImportSavedFileMsg(String path);

  /// No description provided for @exportImportFailureMsg.
  ///
  /// In en, this message translates to:
  /// **'Export unsuccessful.'**
  String get exportImportFailureMsg;

  /// No description provided for @exportImportOverwriteWarningHeader.
  ///
  /// In en, this message translates to:
  /// **'Really OVERWRITE all data?'**
  String get exportImportOverwriteWarningHeader;

  /// No description provided for @exportImportOverwriteWarningBody.
  ///
  /// In en, this message translates to:
  /// **'This will clear all previous content. Ensure you have made a backup of your current data with \'Export\' before proceeding'**
  String get exportImportOverwriteWarningBody;

  /// No description provided for @exportImportOverwriteWarning2Header.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get exportImportOverwriteWarning2Header;

  /// No description provided for @exportImportOverwriteWarning2Body.
  ///
  /// In en, this message translates to:
  /// **'Ensure you have backed up your data with \'Export\'. You cannot recover your initial data after.'**
  String get exportImportOverwriteWarning2Body;

  /// No description provided for @exportImportOverwriteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Overwrite'**
  String get exportImportOverwriteConfirm;

  /// No description provided for @exportImportDataMalformedErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Data was malformed, not all rows were length 3'**
  String get exportImportDataMalformedErrorMsg;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support the Developer'**
  String get supportTitle;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'If this app has helped you achieve your goals, or you appreciate it over other apps available to you, or whatever the reason, consider supporting me by sending me a tip on the ko-fi link below.'**
  String get supportBody;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'version number: {versionNumber}'**
  String versionLabel(String versionNumber);

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @loadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingText;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @editCaloriesCalendarButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editCaloriesCalendarButton;

  /// No description provided for @searchMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchMenuItem;

  /// No description provided for @searchMenuHintText.
  ///
  /// In en, this message translates to:
  /// **'Search by calorie expression or date...'**
  String get searchMenuHintText;

  /// No description provided for @searchMenuExpressionColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Expression'**
  String get searchMenuExpressionColumnLabel;

  /// No description provided for @searchMenuCaloriesColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get searchMenuCaloriesColumnLabel;

  /// No description provided for @searchMenuDateColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get searchMenuDateColumnLabel;

  /// Search results count message
  ///
  /// In en, this message translates to:
  /// **'{amount, plural, =1{Found 1 result} other{Found {amount} results}}'**
  String searchMenuResultText(int amount);

  /// No description provided for @searchMenuNoItemsText1.
  ///
  /// In en, this message translates to:
  /// **'No food items found'**
  String get searchMenuNoItemsText1;

  /// No description provided for @searchMenuNoItemsText2.
  ///
  /// In en, this message translates to:
  /// **'Add some food items to get started'**
  String get searchMenuNoItemsText2;

  /// No description provided for @searchMenuNoItemsFoundText1.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get searchMenuNoItemsFoundText1;

  /// No description provided for @searchMenuNoItemsFoundText2.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search terms'**
  String get searchMenuNoItemsFoundText2;

  /// No description provided for @symbolTableMenu.
  ///
  /// In en, this message translates to:
  /// **'Custom Entry Names'**
  String get symbolTableMenu;

  /// No description provided for @symbolTableDescription.
  ///
  /// In en, this message translates to:
  /// **'Define your own reusable names (ex: Name: egg, Expression: 80)'**
  String get symbolTableDescription;

  /// No description provided for @symbolTableDescriptionExtended.
  ///
  /// In en, this message translates to:
  /// **'Expressions can include the usual math symbols as well as other names you define'**
  String get symbolTableDescriptionExtended;

  /// No description provided for @symbolTableNameColumnHeader.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get symbolTableNameColumnHeader;

  /// No description provided for @symbolTableExpressionColumnHeader.
  ///
  /// In en, this message translates to:
  /// **'Expression'**
  String get symbolTableExpressionColumnHeader;

  /// No description provided for @symbolTableNameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get symbolTableNameRequiredError;

  /// No description provided for @symbolTableExpressionRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Expression is required'**
  String get symbolTableExpressionRequiredError;

  /// No description provided for @symbolTableLoadingFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to load symbols'**
  String get symbolTableLoadingFailure;

  /// No description provided for @symbolExpressionPositiveConstraintFailure.
  ///
  /// In en, this message translates to:
  /// **'Invalid expression: expression must be positive'**
  String get symbolExpressionPositiveConstraintFailure;

  /// No description provided for @symbolExpressionNoneDefinedHint1.
  ///
  /// In en, this message translates to:
  /// **'No custom symbols defined yet.'**
  String get symbolExpressionNoneDefinedHint1;

  /// No description provided for @symbolExpressionNoneDefinedHint2.
  ///
  /// In en, this message translates to:
  /// **'Add your first symbol above!'**
  String get symbolExpressionNoneDefinedHint2;

  /// No description provided for @symbolTableNameExistsError.
  ///
  /// In en, this message translates to:
  /// **'Name {name} already exists. Please choose a different name.'**
  String symbolTableNameExistsError(String name);

  /// No description provided for @symbolTableConfirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete: {name}?'**
  String symbolTableConfirmDelete(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'it', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
