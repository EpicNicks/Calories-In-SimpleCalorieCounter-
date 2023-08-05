package com.aspirant.calorie_tracker

import android.content.ContentValues
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime

const val PICKFILE_RESULT_CODE = 8778

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "csv_downloader").setMethodCallHandler {
            call, result ->
                when (call.method) {
                    "downloadCsv" -> {
                        val csvContent = call.argument<String>("csvContent")
                        if (csvContent != null){
                            val content = downloadCsv(csvContent)
                            if (content != null){
                                result.success(content)
                            }
                            else{
                                result.error("CSV_ERROR", "Invalid CSV content", null)
                            }
                        } else {
                            result.error("CSV_ERROR", "Invalid CSV content.", null)
                        }
                    }
                    "uploadCsv" -> {

                    }
                    else -> result.notImplemented()
                }
        }
    }
    private fun downloadCsv(csvString: String): String? {
        val fileName = "calories_in_backup_${LocalDateTime.now().toString().split(" ").joinToString("_")}.csv" // Set the desired filename and extension

        return try {
            val outputDirectory = Environment.DIRECTORY_DOWNLOADS
            val values = ContentValues().apply {
                put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
                put(MediaStore.MediaColumns.MIME_TYPE, "text/csv")
                put(MediaStore.MediaColumns.RELATIVE_PATH, outputDirectory)
            }

            val resolver = contentResolver
            val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)

            if (uri != null) {
                resolver.openOutputStream(uri).use { output ->
                    output?.write(csvString.toByteArray())
                    output?.flush()
                }
                outputDirectory
            } else {
                null
            }
        } catch (e: Exception) {
            null
        }
    }

}
