// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get language => 'Italiano';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return 'Calorie Totali Giornaliere: $totalCalories';
  }

  @override
  String get clearListWarningTitle => 'Cancellare DAVVERO la lista?';

  @override
  String get clearListWarningBody =>
      'Ciò cancellerà TUTTI gli elementi di oggi';

  @override
  String get calorieEntryHistoryTitle => 'Cronologia delle Calorie';

  @override
  String get calorieTrackingSubmenuTitle =>
      'Opzioni di Monitoraggio del Progresso';

  @override
  String get calendarMenuItem => 'Calendario';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return 'Calorie Totali: $totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return 'La tua prima voce è stata il $date';
  }

  @override
  String get emptyHistoryMsg => 'Non hai ancora nessuna voce nella cronologia';

  @override
  String get chartsMenuItem => 'Grafici';

  @override
  String get showAverageLabel => 'Mostra Media';

  @override
  String get excludeTodayLabel => 'Escludi Oggi';

  @override
  String get dateRangeLabel => 'Intervallo di Date';

  @override
  String get dateRage7Days => 'Ultimi 7 Giorni';

  @override
  String get dateRange30Days => 'Ultimi 30 Giorni';

  @override
  String get dateRangeMax => 'Massimo';

  @override
  String get caloriesGoalPlanLabel => 'Piano Obiettivo Calorie';

  @override
  String get caloriesGoalPlanNone => 'Nessuno';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => 'Personalizzato';

  @override
  String get maintenanceCaloriesChartLabel => 'Calorie di Mantenimento';

  @override
  String get daysCaloriesChartLabel => 'Calorie Giornaliere';

  @override
  String get rangeAverageChartLabel => 'Media dell\'Intervallo';

  @override
  String get yourPlanMenuItem => 'Il Tuo Piano';

  @override
  String get metricOption => 'Metrico';

  @override
  String get imperialOption => 'Imperiale';

  @override
  String get genderMale => 'Maschio';

  @override
  String get genderFemale => 'Femmina';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get weightLbs => 'Peso (lbs)';

  @override
  String get heightMetric => 'Altezza (cm)';

  @override
  String get heightFeet => 'Altezza (ft)';

  @override
  String get heightInches => 'Altezza (pollici)';

  @override
  String get age => 'Età';

  @override
  String get activityLevelLabel => 'Il Tuo Livello di Attività';

  @override
  String get activityLevelBedridden => 'Immobilitato a Letto';

  @override
  String get activityLevelSedentary => 'Sedentario';

  @override
  String get activityLevelLight => 'Leggero/1-3 Giorni a Settimana';

  @override
  String get activityLevelModerate => 'Moderato/3-5 Giorni a Settimana';

  @override
  String get activityLevelHard => 'Esercizio Intenso/6-7 Giorni a Settimana';

  @override
  String get activityLevelExtreme =>
      'Estremamente Attivo/Sport e Lavoro Fisico';

  @override
  String get calculateButtonLabel => 'Calcola';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return 'Fab bisogno calorico giornaliero stimato: $calories';
  }

  @override
  String get customGoalPlanPrompt =>
      'Inserisci il tuo obiettivo giornaliero di calorie';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get faqLabel => 'Domande Frequenti';

  @override
  String get tipsLabel => 'Suggerimenti e Istruzioni';

  @override
  String get themeLabel => 'Tema dell\'App';

  @override
  String get exportImportLabel => 'Esporta/Importa Dati';

  @override
  String get supportLabel => 'Supporta lo Sviluppatore';

  @override
  String get faqMarkdown =>
      '# Domande Frequenti\n---\n## Simboli Matematici Utilizzabili per le Voci\n- +, -, x e * per operazioni matematiche\n- , (virgola) per separare gli elementi all\'interno di una voce\n  \\(questo è semanticamente equivalente all\'addizione\\)\n\n---\n\n## Note Opzionali sulle Voci\nPuoi etichettare informazioni aggiuntive, come il nome del cibo registrato o qualsiasi altra cosa tu desideri in un commento\naggiungendo un : (due punti) alla tua voce e aggiungendo il tuo commento dopo, come\\\\\n**100+80+50: uovo e toast con marmellata**\n\n---\n';

  @override
  String get tipsMarkdown =>
      '# Suggerimenti e Istruzioni\n---\n## Come Calcolare le Porzioni Parziali\nLe Porzioni Parziali possono essere inserite come segue:\n\ncalorie-per-porzione x quantità / quantità-per-porzione\n\nQuindi, se hai cereali misurati in porzioni da 60 grammi, hai mangiato 90 grammi e la\nquantità di calorie per porzione è 200, le calorie totali possono essere inserite come:\\\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => 'Cambia il Tema dell\'App';

  @override
  String get lightLabel => 'Chiaro';

  @override
  String get darkLabel => 'Scuro';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get exportImportDataTitle => 'Importa/Esporta Dati';

  @override
  String get exportImportText1 =>
      'Puoi convertire i tuoi dati delle voci in un file CSV, salvato localmente. Assicurati di fare un backup dei dati prima di sovrascriverli.';

  @override
  String get exportImportText2 =>
      'Per l\'esportazione, questa app richiede il permesso di scrivere sullo storage esterno in quanto si tratta di un file .csv e richiederà il permesso per farlo';

  @override
  String get exportImportText3 =>
      'Il file risultante può essere aperto in Excel o in qualsiasi altro programma che accetti file CSV, e può essere utilizzato anche per importare e sovrascrivere dati in questa app.';

  @override
  String get exportImportExportLabel => 'Esporta';

  @override
  String get exportImportImportLabel => 'Importa';

  @override
  String get exportImportSavingMsg => 'salvataggio del file...';

  @override
  String exportImportSavedFileMsg(String path) {
    return 'File salvato in $path';
  }

  @override
  String get exportImportFailureMsg => 'Esportazione non riuscita.';

  @override
  String get exportImportOverwriteWarningHeader =>
      'Sovrascrivere DAVVERO tutti i dati?';

  @override
  String get exportImportOverwriteWarningBody =>
      'Ciò cancellerà tutti i contenuti precedenti. Assicurati di aver eseguito un backup dei tuoi dati attuali con \'Esporta\' prima di procedere';

  @override
  String get exportImportOverwriteWarning2Header => 'Sei sicuro?';

  @override
  String get exportImportOverwriteWarning2Body =>
      'Assicurati di aver eseguito il backup dei tuoi dati con \'Esporta\'. Non potrai recuperare i dati iniziali successivamente.';

  @override
  String get exportImportOverwriteConfirm => 'Conferma Sovrascrittura';

  @override
  String get exportImportDataMalformedErrorMsg =>
      'I dati non erano ben formati, non tutte le righe avevano una lunghezza di 3';

  @override
  String get supportTitle => 'Supporta lo Sviluppatore';

  @override
  String get supportBody =>
      'Se questa app ti ha aiutato a raggiungere i tuoi obiettivi, o la preferisci rispetto ad altre app disponibili o per qualsiasi altra ragione, considera di supportarmi inviandomi una donazione tramite il link Ko-fi sottostante.';

  @override
  String versionLabel(String versionNumber) {
    return 'numero di versione: $versionNumber';
  }

  @override
  String get continueButton => 'Continua';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get loadingText => 'Caricamento...';

  @override
  String get editCaloriesCalendarButton => 'Modificare';

  @override
  String get searchMenuItem => 'Cerca';

  @override
  String get searchMenuHintText => 'Cerca per espressione calorica o data...';

  @override
  String get searchMenuExpressionColumnLabel => 'Espressione';

  @override
  String get searchMenuCaloriesColumnLabel => 'Calorie';

  @override
  String get searchMenuDateColumnLabel => 'Data';

  @override
  String searchMenuResultText(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: 'Trovati $amount risultati',
      one: 'Trovato 1 risultato',
    );
    return '$_temp0';
  }

  @override
  String get searchMenuNoItemsText1 => 'Nessun alimento trovato';

  @override
  String get searchMenuNoItemsText2 => 'Aggiungi degli alimenti per iniziare';

  @override
  String get searchMenuNoItemsFoundText1 => 'Nessun risultato trovato';

  @override
  String get searchMenuNoItemsFoundText2 =>
      'Prova a modificare i termini di ricerca';
}
