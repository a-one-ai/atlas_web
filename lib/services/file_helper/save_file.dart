import 'dart:html' as html;
import 'dart:convert';
import 'dart:typed_data';

// Inside _ResultScreenState

void saveToFile(String fileName, String content) {
  // Convert content to a Uint8List
  List<int> bytes = utf8.encode(content);

  // Create a Blob
  final blob = html.Blob([Uint8List.fromList(bytes)], 'text/plain');

  // Create a temporary URL to the blob
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Create an anchor element
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", fileName)
    ..click();

  // Clean up by revoking the URL
  html.Url.revokeObjectUrl(url);
}