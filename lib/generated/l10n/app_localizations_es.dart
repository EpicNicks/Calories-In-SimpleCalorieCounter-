// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Español';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return 'Total de Calorías Diarias: $totalCalories';
  }

  @override
  String get clearListWarningTitle => '¿Realmente BORRAR la lista?';

  @override
  String get clearListWarningBody =>
      'Esto eliminará TODOS los elementos de hoy';

  @override
  String get calorieEntryHistoryTitle => 'Historial de Entradas de Calorías';

  @override
  String get calorieTrackingSubmenuTitle =>
      'Opciones de Seguimiento de Progreso';

  @override
  String get calendarMenuItem => 'Calendario';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return 'Calorías Totales: $totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return 'Tu primera entrada fue el $date';
  }

  @override
  String get emptyHistoryMsg => 'Aún no tienes entradas en tu historial';

  @override
  String get chartsMenuItem => 'Gráficos';

  @override
  String get showAverageLabel => 'Mostrar Promedio';

  @override
  String get excludeTodayLabel => 'Excluir Hoy';

  @override
  String get dateRangeLabel => 'Rango de Fechas';

  @override
  String get dateRage7Days => 'Últimos 7 Días';

  @override
  String get dateRange30Days => 'Últimos 30 Días';

  @override
  String get dateRangeMax => 'Máximo';

  @override
  String get caloriesGoalPlanLabel => 'Plan de Objetivo de Calorías';

  @override
  String get caloriesGoalPlanNone => 'Ninguno';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => 'Personalizado';

  @override
  String get maintenanceCaloriesChartLabel => 'Calorías de Mantenimiento';

  @override
  String get daysCaloriesChartLabel => 'Calorías del Día';

  @override
  String get rangeAverageChartLabel => 'Promedio del Rango';

  @override
  String get yourPlanMenuItem => 'Tu Plan';

  @override
  String get metricOption => 'Métrico';

  @override
  String get imperialOption => 'Imperial';

  @override
  String get genderMale => 'Hombre';

  @override
  String get genderFemale => 'Mujer';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get weightLbs => 'Peso (lbs)';

  @override
  String get heightMetric => 'Altura (cm)';

  @override
  String get heightFeet => 'Altura (pies)';

  @override
  String get heightInches => 'Altura (pulgadas)';

  @override
  String get age => 'Edad';

  @override
  String get activityLevelLabel => 'Tu nivel de actividad';

  @override
  String get activityLevelBedridden => 'Postrado en Cama';

  @override
  String get activityLevelSedentary => 'Sedentario';

  @override
  String get activityLevelLight => 'Ligero/1-3 Días por Semana';

  @override
  String get activityLevelModerate => 'Moderado/3-5 Días por Semana';

  @override
  String get activityLevelHard => 'Ejercicio Intenso/6-7 Días por Semana';

  @override
  String get activityLevelExtreme =>
      'Extremadamente Activo/Deportes y Trabajo Físico';

  @override
  String get calculateButtonLabel => 'Calcular';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return 'Necesidades Diarias Estimadas de Calorías: $calories';
  }

  @override
  String get customGoalPlanPrompt => 'Ingresa tu objetivo diario de calorías';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get faqLabel => 'Preguntas Frecuentes';

  @override
  String get tipsLabel => 'Consejos y Guías';

  @override
  String get themeLabel => 'Tema de la App';

  @override
  String get exportImportLabel => 'Exportar/Importar Datos';

  @override
  String get supportLabel => 'Apoyar al Desarrollador';

  @override
  String get faqMarkdown =>
      '# Preguntas Frecuentes\n---\n## Símbolos Matemáticos Utilizables para Entradas\n- +, -, x y * para operaciones matemáticas\n- , (coma) para separar elementos dentro de una entrada\n  \\(esto es semánticamente equivalente a la suma\\)\n\n---\n\n## Notas Opcionales en las Entradas\nPuedes etiquetar información adicional, como el nombre del alimento registrado o cualquier otra cosa que desees en un comentario\nagregando un : (dos puntos) a tu entrada y agregando tu comentario después, como\\\\\n**100+80+50: huevo y tostada con mermelada**\n\n---\n';

  @override
  String get tipsMarkdown =>
      '# Consejos y Guías\n---\n## Cómo Calcular Porciones Parciales\nLas Porciones Parciales se pueden ingresar de la siguiente manera:\n\ncalorías-por-porción x cantidad / cantidad-por-porción\n\nAsí que si tienes cereales que se miden en porciones de 60 gramos, comiste 90 gramos de ellos y la\ncantidad de calorías por porción es 200, las calorías totales se pueden ingresar como:\\\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => 'Cambiar Tema de la App';

  @override
  String get lightLabel => 'Claro';

  @override
  String get darkLabel => 'Oscuro';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get exportImportDataTitle => 'Importar/Exportar Datos';

  @override
  String get exportImportText1 =>
      'Puedes convertir tus datos de entradas en un archivo CSV, guardado localmente. Asegúrate de respaldar los datos antes de sobrescribir.';

  @override
  String get exportImportText2 =>
      'Para exportar, esta aplicación requiere permiso para escribir en el almacenamiento externo, ya que es un archivo .csv, y pedirá permiso para hacerlo.';

  @override
  String get exportImportText3 =>
      'El archivo resultante puede abrirse en Excel o cualquier otro programa que acepte archivos CSV, y también se puede usar para importar y sobrescribir datos en esta aplicación.';

  @override
  String get exportImportExportLabel => 'Exportar';

  @override
  String get exportImportImportLabel => 'Importar';

  @override
  String get exportImportSavingMsg => 'guardando archivo...';

  @override
  String exportImportSavedFileMsg(String path) {
    return 'Archivo guardado en $path';
  }

  @override
  String get exportImportFailureMsg => 'Exportación fallida.';

  @override
  String get exportImportOverwriteWarningHeader =>
      '¿Realmente SOBRESCRIBIR todos los datos?';

  @override
  String get exportImportOverwriteWarningBody =>
      'Esto eliminará todo el contenido anterior. Asegúrate de haber realizado una copia de seguridad de tus datos actuales con \'Exportar\' antes de continuar';

  @override
  String get exportImportOverwriteWarning2Header => '¿Estás seguro?';

  @override
  String get exportImportOverwriteWarning2Body =>
      'Asegúrate de haber respaldado tus datos con \'Exportar\'. No podrás recuperar tus datos iniciales después.';

  @override
  String get exportImportOverwriteConfirm => 'Confirmar Sobrescritura';

  @override
  String get exportImportDataMalformedErrorMsg =>
      'Los datos estaban mal formateados, no todas las filas tenían una longitud de 3';

  @override
  String get supportTitle => 'Apoyar al Desarrollador';

  @override
  String get supportBody =>
      'Si esta aplicación te ha ayudado a alcanzar tus objetivos, o la prefieres sobre otras aplicaciones disponibles, o por cualquier razón, considera apoyarme enviándome una propina en el enlace de Ko-fi que se encuentra abajo.';

  @override
  String versionLabel(String versionNumber) {
    return 'número de versión: $versionNumber';
  }

  @override
  String get continueButton => 'Continuar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get loadingText => 'Cargando...';

  @override
  String get editCaloriesCalendarButton => 'Editar';

  @override
  String get searchMenuItem => 'Buscar';

  @override
  String get searchMenuHintText =>
      'Buscar por expresión de calorías o fecha...';

  @override
  String get searchMenuExpressionColumnLabel => 'Expresión';

  @override
  String get searchMenuCaloriesColumnLabel => 'Calorías';

  @override
  String get searchMenuDateColumnLabel => 'Fecha';

  @override
  String searchMenuResultText(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: 'Se encontraron $amount resultados',
      one: 'Se encontró 1 resultado',
    );
    return '$_temp0';
  }

  @override
  String get searchMenuNoItemsText1 => 'No se encontraron alimentos';

  @override
  String get searchMenuNoItemsText2 => 'Agrega algunos alimentos para comenzar';

  @override
  String get searchMenuNoItemsFoundText1 => 'No se encontraron resultados';

  @override
  String get searchMenuNoItemsFoundText2 =>
      'Intenta ajustar tus términos de búsqueda';
}
