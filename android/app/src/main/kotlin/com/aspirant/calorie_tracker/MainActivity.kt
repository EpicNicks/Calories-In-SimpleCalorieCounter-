package com.aspirant.calorie_tracker

import android.content.ContentValues
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
import java.lang.StringBuilder
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
                    else -> result.notImplemented()
                }
        }
    }

    private fun downloadCsv(csvString: String): String? {
        val directory = getDownloadsDirectory()
        val fileName = "calories_in_backup_${LocalDateTime.now().toString().split(" ").joinToString("_")}.csv" // Set the desired filename and extension
        val file = File(directory, fileName)

        return try {
            val values = ContentValues().apply {
                put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
                put(MediaStore.MediaColumns.MIME_TYPE, "text/csv")
                put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
            }

            val resolver = context.contentResolver
            val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)

            if (uri != null) {
                resolver.openOutputStream(uri).use { output ->
                    output?.write(csvString.toByteArray())
                    output?.flush()
                }
                file.path
            } else {
                null
            }
        } catch (e: Exception) {
            null
        }
    }

    private fun getDownloadsDirectory(): File {
        val externalStoragePermission = "android.permission.MANAGE_EXTERNAL_STORAGE"
        if (ContextCompat.checkSelfPermission(context, externalStoragePermission) == PackageManager.PERMISSION_GRANTED) {
            return Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
        }
        return context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS) ?: context.filesDir
    }

}
