// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get language => '日本語';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return '今日のカロリー合計: $totalCalories';
  }

  @override
  String get clearListWarningTitle => 'リストを本当にクリアしますか？';

  @override
  String get clearListWarningBody => 'これで今日の全てのアイテムが削除されます';

  @override
  String get calorieEntryHistoryTitle => 'カロリー入力ログ';

  @override
  String get calorieTrackingSubmenuTitle => '\"進捗トラッキングオプション';

  @override
  String get calendarMenuItem => 'カレンダー';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return '総カロリー: $totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return '最初の記録は$dateです';
  }

  @override
  String get emptyHistoryMsg => 'まだ履歴にエントリーがない';

  @override
  String get chartsMenuItem => 'グラフ';

  @override
  String get showAverageLabel => '平均';

  @override
  String get excludeTodayLabel => '今日除外';

  @override
  String get dateRangeLabel => '日付の範囲';

  @override
  String get dateRage7Days => '過去7日間';

  @override
  String get dateRange30Days => '過去30日間';

  @override
  String get dateRangeMax => '最大範囲';

  @override
  String get caloriesGoalPlanLabel => 'カロリーゴールプラン';

  @override
  String get caloriesGoalPlanNone => 'なし';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => 'カスタム';

  @override
  String get maintenanceCaloriesChartLabel => '維持カロリー';

  @override
  String get daysCaloriesChartLabel => '本日のカロリー';

  @override
  String get rangeAverageChartLabel => '範囲平均';

  @override
  String get yourPlanMenuItem => 'プラン';

  @override
  String get metricOption => 'メートル法';

  @override
  String get imperialOption => 'ヤードポンド法';

  @override
  String get genderMale => '男';

  @override
  String get genderFemale => '女';

  @override
  String get weightKg => '体重（kg）';

  @override
  String get weightLbs => '体重（ポンド）';

  @override
  String get heightMetric => '身長（cm）';

  @override
  String get heightFeet => '身長（フィート）';

  @override
  String get heightInches => '身長（インチ）';

  @override
  String get age => '年齢（歳）';

  @override
  String get activityLevelLabel => '活動レベル';

  @override
  String get activityLevelBedridden => '寝たきり';

  @override
  String get activityLevelSedentary => '低い運動レベル';

  @override
  String get activityLevelLight => '軽い（週1-3日）';

  @override
  String get activityLevelModerate => '適度な（週3-5日）';

  @override
  String get activityLevelHard => '激しい運動（週6-7日）';

  @override
  String get activityLevelExtreme => '非常に活発（スポーツ・肉体労働）';

  @override
  String get calculateButtonLabel => '計算する';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return '推定1日のカロリー必要量: $calories';
  }

  @override
  String get customGoalPlanPrompt => '目標カロリーを入力';

  @override
  String get settingsTitle => '設定';

  @override
  String get faqLabel => 'よくある質問';

  @override
  String get tipsLabel => 'ヒントとハウツ';

  @override
  String get themeLabel => 'アプリのテーマ';

  @override
  String get exportImportLabel => 'データのエクスポート/インポート';

  @override
  String get supportLabel => '開発者への支援';

  @override
  String get faqMarkdown =>
      '# FAQ\n---\n## 記入に使用できる数学記号\n- +、-、x および * は数学の演算に使用します\n- ,（コンマ）はエントリ内の項目を区切るための記号です\n  \\\\（これは意味的には加算と同等です\\\\）\n\n---\n\n## エントリへのオプションのメモ\n食品の名前などの追加情報をラベル付けすることができます。コメントを追加するには、エントリに :（コロン）を追加し、コメントを後ろに追加します。例：\n\n**100+80+50: 卵とトースト（ジャム付き）**\n\n---\n';

  @override
  String get tipsMarkdown =>
      '# ヒントとハウツー\n---\n## 部分のサービングの計算方法\n部分のサービングは次のように入力できます：\n\nサービングごとのカロリー x 量 / サービングごとの量\n\n例えば、60グラムのサービングで測定されたシリアルを90グラム食べ、\nサービングごとのカロリーが200だった場合、総カロリーは以下のように入力できます：\n\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => 'アプリテーマの変更';

  @override
  String get lightLabel => 'ライト';

  @override
  String get darkLabel => 'ダーク';

  @override
  String get systemLabel => 'システム';

  @override
  String get exportImportDataTitle => 'データのエクスポート/インポート';

  @override
  String get exportImportText1 =>
      'エントリデータをCSVに変換して、ローカルに保存できます。上書きする前にデータをバックアップしてください。';

  @override
  String get exportImportText2 =>
      'エクスポートには、このアプリが外部ストレージに書き込む許可が必要です。それは .csv ファイルであり、そのための許可を求めます。';

  @override
  String get exportImportText3 =>
      '結果のファイルは、ExcelやCSVファイルを受け入れる他のプログラムで開けるだけでなく、このアプリにデータをインポートして上書きするためにも使用できます。';

  @override
  String get exportImportExportLabel => 'エクスポート';

  @override
  String get exportImportImportLabel => 'インポート';

  @override
  String get exportImportSavingMsg => 'ファイルを保存しています...';

  @override
  String exportImportSavedFileMsg(String path) {
    return '$path にファイルを保存しました。';
  }

  @override
  String get exportImportFailureMsg => 'エクスポートが失敗しました。';

  @override
  String get exportImportOverwriteWarningHeader => '本当にすべてのデータを上書きしますか？';

  @override
  String get exportImportOverwriteWarningBody =>
      '\'エクスポート\' で現在のデータをバックアップしたことを確認してから進んでください。これにより以前のすべての内容が消去されます。';

  @override
  String get exportImportOverwriteWarning2Header => '本当ですか？';

  @override
  String get exportImportOverwriteWarning2Body =>
      '\'エクスポート\' でデータをバックアップしていることを確認してください。初期データは回復できません。';

  @override
  String get exportImportOverwriteConfirm => '上書きを確認。';

  @override
  String get exportImportDataMalformedErrorMsg =>
      'データが不正で、すべての行が長さ 3 ではありませんでした。';

  @override
  String get supportTitle => 'ご支援を希望の場合';

  @override
  String get supportBody =>
      'もしこのアプリがあなたの目標達成に役立ちました、または他の利用可能なアプリと比べて、もしくはその他の理由で、私のサポートを感じていただけるのであれば、以下の ko-fi リンクからお気持ちのサポートをいただければ幸いです。';

  @override
  String versionLabel(String versionNumber) {
    return 'バージョン番号: $versionNumber';
  }

  @override
  String get continueButton => 'OK';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get loadingText => '読み込み中...';

  @override
  String get updateButton => '更新';

  @override
  String get deleteButton => '削除';

  @override
  String get editCaloriesCalendarButton => 'エディット';

  @override
  String get searchMenuItem => '検索';

  @override
  String get searchMenuHintText => 'カロリーの式または日付で検索...';

  @override
  String get searchMenuExpressionColumnLabel => '式';

  @override
  String get searchMenuCaloriesColumnLabel => 'カロリー';

  @override
  String get searchMenuDateColumnLabel => '日付';

  @override
  String searchMenuResultText(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount件の結果が見つかりました',
      one: '1件の結果が見つかりました',
    );
    return '$_temp0';
  }

  @override
  String get searchMenuNoItemsText1 => '食品が見つかりませんでした';

  @override
  String get searchMenuNoItemsText2 => '食品を追加して始めましょう';

  @override
  String get searchMenuNoItemsFoundText1 => '結果が見つかりませんでした';

  @override
  String get searchMenuNoItemsFoundText2 => '検索語句を調整してみてください';

  @override
  String get symbolTableMenu => 'カスタムエントリ名';

  @override
  String get symbolTableDescription => '再利用可能な名前を定義します（例：名前：卵、式：80）';

  @override
  String get symbolTableDescriptionExtended => '式には通常の数学記号や定義した他の名前を使用できます';

  @override
  String get symbolTableNameColumnHeader => '名前';

  @override
  String get symbolTableExpressionColumnHeader => '式';

  @override
  String get symbolTableNameRequiredError => '名前は必須です';

  @override
  String get symbolTableExpressionRequiredError => '式は必須です';

  @override
  String get symbolTableLoadingFailure => 'シンボルの読み込みに失敗しました';

  @override
  String get symbolExpressionPositiveConstraintFailure => '無効な式：正の値である必要があります';

  @override
  String get symbolExpressionNoneDefinedHint1 => 'カスタムシンボルはまだ定義されていません。';

  @override
  String get symbolExpressionNoneDefinedHint2 => '上で最初のシンボルを追加しましょう！';

  @override
  String symbolTableNameExistsError(String name) {
    return '名前 $name はすでに存在します。別の名前を選んでください。';
  }

  @override
  String symbolTableConfirmDelete(String name) {
    return '削除しますか: $name？';
  }
}
