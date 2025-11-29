import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:docx_to_text/docx_to_text.dart';

Future<String?> parseResumeFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'docx'],
    withData: true,
  );

  if (result == null) return null;

  final file = result.files.first;

  if (file.bytes == null) return null;

  if (file.extension == "pdf") {
    if (file.path == null) return null;
    PDFDoc doc = await PDFDoc.fromFile(File(file.path!));
    return await doc.text;
  } else if (file.extension == "docx") {
    return docxToText(file.bytes!);
  }

  return null;
}
