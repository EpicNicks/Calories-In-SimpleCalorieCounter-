// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get language => '中文';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return '每日总热量：$totalCalories';
  }

  @override
  String get clearListWarningTitle => '确定要清空列表吗？';

  @override
  String get clearListWarningBody => '这将删除今天的所有记录';

  @override
  String get calorieEntryHistoryTitle => '热量记录历史';

  @override
  String get calorieTrackingSubmenuTitle => '进展跟踪选项';

  @override
  String get calendarMenuItem => '日历';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return '总热量：$totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return '你的首条记录是在 $date';
  }

  @override
  String get emptyHistoryMsg => '你的历史记录中还没有任何记录';

  @override
  String get chartsMenuItem => '图表';

  @override
  String get showAverageLabel => '显示平均值';

  @override
  String get excludeTodayLabel => '排除今天';

  @override
  String get dateRangeLabel => '日期范围';

  @override
  String get dateRage7Days => '过去7天';

  @override
  String get dateRange30Days => '过去30天';

  @override
  String get dateRangeMax => '最大';

  @override
  String get caloriesGoalPlanLabel => '热量目标计划';

  @override
  String get caloriesGoalPlanNone => '无';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => '自定义';

  @override
  String get maintenanceCaloriesChartLabel => '维持热量';

  @override
  String get daysCaloriesChartLabel => '每日热量';

  @override
  String get rangeAverageChartLabel => '范围平均值';

  @override
  String get yourPlanMenuItem => '你的计划';

  @override
  String get metricOption => '公制';

  @override
  String get imperialOption => '英制';

  @override
  String get genderMale => '男性';

  @override
  String get genderFemale => '女性';

  @override
  String get weightKg => '体重（公斤）';

  @override
  String get weightLbs => '体重（磅）';

  @override
  String get heightMetric => '身高（厘米）';

  @override
  String get heightFeet => '身高（英尺）';

  @override
  String get heightInches => '身高（英寸）';

  @override
  String get age => '年龄';

  @override
  String get activityLevelLabel => '你的活动水平';

  @override
  String get activityLevelBedridden => '卧床';

  @override
  String get activityLevelSedentary => '久坐';

  @override
  String get activityLevelLight => '轻度/每周1-3天';

  @override
  String get activityLevelModerate => '适度/每周3-5天';

  @override
  String get activityLevelHard => '剧烈运动/每周6-7天';

  @override
  String get activityLevelExtreme => '极度活跃/体育和体力劳动工作';

  @override
  String get calculateButtonLabel => '计算';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return '估算每日热量需求：$calories';
  }

  @override
  String get customGoalPlanPrompt => '输入你的每日热量目标';

  @override
  String get settingsTitle => '设置';

  @override
  String get faqLabel => '常见问题';

  @override
  String get tipsLabel => '提示和使用方法';

  @override
  String get themeLabel => '应用主题';

  @override
  String get exportImportLabel => '导入/导出数据';

  @override
  String get supportLabel => '支持开发者';

  @override
  String get faqMarkdown =>
      '# 常见问题\n---\n## 可用的数学符号用于记录\n- +、-、x 和 * 用于数学运算\n- 逗号（,）用于在记录中分隔项目\n  \\（这在语义上等同于加法\\）\n\n---\n\n## 记录中的可选注释\n你可以通过在记录中添加冒号（:）和随后添加你的注释来标记额外的信息，例如食物名称或其他内容，如\\\\\n**100+80+50: 鸡蛋和吐司配果酱**\n\n---\n';

  @override
  String get tipsMarkdown =>
      '# 提示和使用方法\n---\n## 如何计算部分份额\n部分份额可以输入如下方式：\n\n每份热量 x 数量 / 每份量\n\n因此，如果你有以60克为单位的麦片，你吃了90克，每份热量为200，总热量可以输入如下：\\\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => '更改应用主题';

  @override
  String get lightLabel => '亮色';

  @override
  String get darkLabel => '暗色';

  @override
  String get systemLabel => '跟随系统';

  @override
  String get exportImportDataTitle => '导入/导出热量数据';

  @override
  String get exportImportText1 => '你可以将你的记录数据转换为本地保存的 CSV 文件。在覆盖之前确保备份了数据。';

  @override
  String get exportImportText2 =>
      '为了导出，此应用需要您允许它写入外部存储，因为它是一个 .csv 文件，会要求获得权限。';

  @override
  String get exportImportText3 =>
      '导出的文件可以在 Excel 或任何接受 CSV 格式的程序中打开，也可以用于导入和覆盖此应用中的数据。';

  @override
  String get exportImportExportLabel => '导出';

  @override
  String get exportImportImportLabel => '导入';

  @override
  String get exportImportSavingMsg => '正在保存文件...';

  @override
  String exportImportSavedFileMsg(String path) {
    return '文件已保存至 $path';
  }

  @override
  String get exportImportFailureMsg => '导出失败。';

  @override
  String get exportImportOverwriteWarningHeader => '真的要覆盖所有数据吗？';

  @override
  String get exportImportOverwriteWarningBody =>
      '这将清除所有先前内容。在继续之前，请确保通过“导出”创建了当前数据的备份。';

  @override
  String get exportImportOverwriteWarning2Header => '你确定吗？';

  @override
  String get exportImportOverwriteWarning2Body =>
      '在继续之前，请确保通过“导出”创建了数据的备份。之后将无法恢复最初的数据。';

  @override
  String get exportImportOverwriteConfirm => '确认覆盖';

  @override
  String get exportImportDataMalformedErrorMsg => '数据格式错误，不是所有行的长度都为3';

  @override
  String get supportTitle => '支持开发者';

  @override
  String get supportBody =>
      '如果此应用帮助你实现了目标，或者你喜欢它胜过其他可用的应用，或者出于其他原因，考虑通过下面的 Ko-fi 链接向我赞赏一下。';

  @override
  String versionLabel(String versionNumber) {
    return '版本号：$versionNumber';
  }

  @override
  String get continueButton => '继续';

  @override
  String get cancelButton => '取消';

  @override
  String get loadingText => '加载中...';

  @override
  String get editCaloriesCalendarButton => '编辑';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get language => '中文';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return '每日总热量：$totalCalories';
  }

  @override
  String get clearListWarningTitle => '确定要清空列表吗？';

  @override
  String get clearListWarningBody => '这将删除今天的所有记录';

  @override
  String get calorieEntryHistoryTitle => '热量记录历史';

  @override
  String get calorieTrackingSubmenuTitle => '进展跟踪选项';

  @override
  String get calendarMenuItem => '日历';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return '总热量：$totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return '你的首条记录是在 $date';
  }

  @override
  String get emptyHistoryMsg => '你的历史记录中还没有任何记录';

  @override
  String get chartsMenuItem => '图表';

  @override
  String get showAverageLabel => '显示平均值';

  @override
  String get excludeTodayLabel => '排除今天';

  @override
  String get dateRangeLabel => '日期范围';

  @override
  String get dateRage7Days => '过去7天';

  @override
  String get dateRange30Days => '过去30天';

  @override
  String get dateRangeMax => '最大';

  @override
  String get caloriesGoalPlanLabel => '热量目标计划';

  @override
  String get caloriesGoalPlanNone => '无';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => '自定义';

  @override
  String get maintenanceCaloriesChartLabel => '维持热量';

  @override
  String get daysCaloriesChartLabel => '每日热量';

  @override
  String get rangeAverageChartLabel => '范围平均值';

  @override
  String get yourPlanMenuItem => '你的计划';

  @override
  String get metricOption => '公制';

  @override
  String get imperialOption => '英制';

  @override
  String get genderMale => '男性';

  @override
  String get genderFemale => '女性';

  @override
  String get weightKg => '体重（公斤）';

  @override
  String get weightLbs => '体重（磅）';

  @override
  String get heightMetric => '身高（厘米）';

  @override
  String get heightFeet => '身高（英尺）';

  @override
  String get heightInches => '身高（英寸）';

  @override
  String get age => '年龄';

  @override
  String get activityLevelLabel => '你的活动水平';

  @override
  String get activityLevelBedridden => '卧床';

  @override
  String get activityLevelSedentary => '久坐';

  @override
  String get activityLevelLight => '轻度/每周1-3天';

  @override
  String get activityLevelModerate => '适度/每周3-5天';

  @override
  String get activityLevelHard => '剧烈运动/每周6-7天';

  @override
  String get activityLevelExtreme => '极度活跃/体育和体力劳动工作';

  @override
  String get calculateButtonLabel => '计算';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return '估算每日热量需求：$calories';
  }

  @override
  String get customGoalPlanPrompt => '输入你的每日热量目标';

  @override
  String get settingsTitle => '设置';

  @override
  String get faqLabel => '常见问题';

  @override
  String get tipsLabel => '提示和使用方法';

  @override
  String get themeLabel => '应用主题';

  @override
  String get exportImportLabel => '导入/导出数据';

  @override
  String get supportLabel => '支持开发者';

  @override
  String get faqMarkdown =>
      '# 常见问题\n---\n## 可用的数学符号用于记录\n- +、-、x 和 * 用于数学运算\n- 逗号（,）用于在记录中分隔项目\n  \\（这在语义上等同于加法\\）\n\n---\n\n## 记录中的可选注释\n你可以通过在记录中添加冒号（:）和随后添加你的注释来标记额外的信息，例如食物名称或其他内容，如\\\\\n**100+80+50: 鸡蛋和吐司配果酱**\n\n---\n';

  @override
  String get tipsMarkdown =>
      '# 提示和使用方法\n---\n## 如何计算部分份额\n部分份额可以输入如下方式：\n\n每份热量 x 数量 / 每份量\n\n因此，如果你有以60克为单位的麦片，你吃了90克，每份热量为200，总热量可以输入如下：\\\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => '更改应用主题';

  @override
  String get lightLabel => '亮色';

  @override
  String get darkLabel => '暗色';

  @override
  String get systemLabel => '跟随系统';

  @override
  String get exportImportDataTitle => '导入/导出热量数据';

  @override
  String get exportImportText1 => '你可以将你的记录数据转换为本地保存的 CSV 文件。在覆盖之前确保备份了数据。';

  @override
  String get exportImportText2 =>
      '为了导出，此应用需要您允许它写入外部存储，因为它是一个 .csv 文件，会要求获得权限。';

  @override
  String get exportImportText3 =>
      '导出的文件可以在 Excel 或任何接受 CSV 格式的程序中打开，也可以用于导入和覆盖此应用中的数据。';

  @override
  String get exportImportExportLabel => '导出';

  @override
  String get exportImportImportLabel => '导入';

  @override
  String get exportImportSavingMsg => '正在保存文件...';

  @override
  String exportImportSavedFileMsg(String path) {
    return '文件已保存至 $path';
  }

  @override
  String get exportImportFailureMsg => '导出失败。';

  @override
  String get exportImportOverwriteWarningHeader => '真的要覆盖所有数据吗？';

  @override
  String get exportImportOverwriteWarningBody =>
      '这将清除所有先前内容。在继续之前，请确保通过“导出”创建了当前数据的备份。';

  @override
  String get exportImportOverwriteWarning2Header => '你确定吗？';

  @override
  String get exportImportOverwriteWarning2Body =>
      '在继续之前，请确保通过“导出”创建了数据的备份。之后将无法恢复最初的数据。';

  @override
  String get exportImportOverwriteConfirm => '确认覆盖';

  @override
  String get exportImportDataMalformedErrorMsg => '数据格式错误，不是所有行的长度都为3';

  @override
  String get supportTitle => '支持开发者';

  @override
  String get supportBody =>
      '如果此应用帮助你实现了目标，或者你喜欢它胜过其他可用的应用，或者出于其他原因，考虑通过下面的 Ko-fi 链接向我赞赏一下。';

  @override
  String versionLabel(String versionNumber) {
    return '版本号：$versionNumber';
  }

  @override
  String get continueButton => '继续';

  @override
  String get cancelButton => '取消';

  @override
  String get loadingText => '加载中...';

  @override
  String get editCaloriesCalendarButton => '编辑';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get language => '繁體中文';

  @override
  String dailyCalorieTotal(int totalCalories) {
    return '每日總熱量：$totalCalories';
  }

  @override
  String get clearListWarningTitle => '確定要清空列表嗎？';

  @override
  String get clearListWarningBody => '這將刪除今天的所有記錄';

  @override
  String get calorieEntryHistoryTitle => '熱量記錄歷史';

  @override
  String get calorieTrackingSubmenuTitle => '進展追蹤選項';

  @override
  String get calendarMenuItem => '日曆';

  @override
  String caloriesTotalLabel(int totalCalories) {
    return '總熱量：$totalCalories';
  }

  @override
  String yourFirstEntryText(String date) {
    return '你的首條記錄是在 $date';
  }

  @override
  String get emptyHistoryMsg => '你的歷史記錄中還沒有任何記錄';

  @override
  String get chartsMenuItem => '圖表';

  @override
  String get showAverageLabel => '顯示平均值';

  @override
  String get excludeTodayLabel => '排除今天';

  @override
  String get dateRangeLabel => '日期範圍';

  @override
  String get dateRage7Days => '過去7天';

  @override
  String get dateRange30Days => '過去30天';

  @override
  String get dateRangeMax => '最大';

  @override
  String get caloriesGoalPlanLabel => '熱量目標計劃';

  @override
  String get caloriesGoalPlanNone => '無';

  @override
  String get caloriesGoalPlanMSJ => 'Mifflin-St Jeor';

  @override
  String get caloriesGoalPlanCustom => '自訂';

  @override
  String get maintenanceCaloriesChartLabel => '維持熱量';

  @override
  String get daysCaloriesChartLabel => '每日熱量';

  @override
  String get rangeAverageChartLabel => '範圍平均值';

  @override
  String get yourPlanMenuItem => '你的計劃';

  @override
  String get metricOption => '公制';

  @override
  String get imperialOption => '英制';

  @override
  String get genderMale => '男性';

  @override
  String get genderFemale => '女性';

  @override
  String get weightKg => '體重（公斤）';

  @override
  String get weightLbs => '體重（磅）';

  @override
  String get heightMetric => '身高（厘米）';

  @override
  String get heightFeet => '身高（英尺）';

  @override
  String get heightInches => '身高（英寸）';

  @override
  String get age => '年齡';

  @override
  String get activityLevelLabel => '你的活動水平';

  @override
  String get activityLevelBedridden => '卧床';

  @override
  String get activityLevelSedentary => '久坐';

  @override
  String get activityLevelLight => '輕度/每週1-3天';

  @override
  String get activityLevelModerate => '適度/每週3-5天';

  @override
  String get activityLevelHard => '劇烈運動/每週6-7天';

  @override
  String get activityLevelExtreme => '極度活躍/體育和體力勞動工作';

  @override
  String get calculateButtonLabel => '計算';

  @override
  String estimatedDailyNeedsLabel(int calories) {
    return '估算每日熱量需求：$calories';
  }

  @override
  String get customGoalPlanPrompt => '輸入你的每日熱量目標';

  @override
  String get settingsTitle => '設定';

  @override
  String get faqLabel => '常見問題';

  @override
  String get tipsLabel => '提示和使用方法';

  @override
  String get themeLabel => '應用主題';

  @override
  String get exportImportLabel => '導入/導出數據';

  @override
  String get supportLabel => '支持開發者';

  @override
  String get faqMarkdown =>
      '# 常見問題\n---\n## 可用的數學符號用於記錄\n- +、-、x 和 * 用於數學運算\n- 逗號（,）用於在記錄中分隔項目\n  \\（這在語義上等同於加法\\）\n\n---\n## 記錄中的可選注釋\n你可以通過在記錄中添加冒號（:）並隨後添加你的注釋來標記額外的信息，例如食物名稱或其他內容，如\\\\\n**100+80+50: 雞蛋和吐司配果醬**\n\n---\n';

  @override
  String get tipsMarkdown =>
      '# 提示和使用方法\n---\n## 如何計算部分份額\n部分份額可以輸入如下方式：\n\n每份熱量 x 數量 / 每份量\n\n因此，如果你有以60克為單位的麥片，你吃了90克，每份熱量為200，總熱量可以輸入如下：\\\n**200 x 90 / 60** ***(=300)***\n\n---\n';

  @override
  String get appThemeTitle => '更改應用主題';

  @override
  String get lightLabel => '亮色';

  @override
  String get darkLabel => '暗色';

  @override
  String get systemLabel => '跟隨系統';

  @override
  String get exportImportDataTitle => '導入/導出熱量數據';

  @override
  String get exportImportText1 => '你可以將你的記錄數據轉換為本地保存的 CSV 文件。在覆蓋之前確保備份了數據。';

  @override
  String get exportImportText2 =>
      '為了導出，此應用需要您允許它寫入外部存儲，因為它是一個 .csv 文件，會要求獲得權限。';

  @override
  String get exportImportText3 =>
      '導出的文件可以在 Excel 或任何接受 CSV 格式的程式中打開，也可以用於導入和覆蓋此應用中的數據。';

  @override
  String get exportImportExportLabel => '導出';

  @override
  String get exportImportImportLabel => '導入';

  @override
  String get exportImportSavingMsg => '正在保存文件...';

  @override
  String exportImportSavedFileMsg(String path) {
    return '文件已保存至 $path';
  }

  @override
  String get exportImportFailureMsg => '導出失敗。';

  @override
  String get exportImportOverwriteWarningHeader => '確定要覆蓋所有數據嗎？';

  @override
  String get exportImportOverwriteWarningBody =>
      '這將清除所有先前內容。在繼續之前，請確保通過“導出”創建了當前數據的備份。';

  @override
  String get exportImportOverwriteWarning2Header => '你確定嗎？';

  @override
  String get exportImportOverwriteWarning2Body =>
      '在繼續之前，請確保通過“導出”創建了數據的備份。之後將無法恢復最初的數據。';

  @override
  String get exportImportOverwriteConfirm => '確認覆蓋';

  @override
  String get exportImportDataMalformedErrorMsg => '數據格式錯誤，不是所有行的長度都為3';

  @override
  String get supportTitle => '支持開發者';

  @override
  String get supportBody =>
      '如果此應用幫助你實現了目標，或者你喜歡它勝過其他可用的應用，或者出於其他原因，考慮通過下面的 Ko-fi 鏈接向我贊助一下。';

  @override
  String versionLabel(String versionNumber) {
    return '版本號：$versionNumber';
  }

  @override
  String get continueButton => '繼續';

  @override
  String get cancelButton => '取消';

  @override
  String get loadingText => '載入中...';

  @override
  String get editCaloriesCalendarButton => '編輯';
}
