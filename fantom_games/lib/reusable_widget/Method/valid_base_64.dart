import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

bool isValidBase64(String base64String) {
  try {
    List<int> bytes = base64.decode(base64String);
    img.decodeImage(Uint8List.fromList(bytes));
    return true;
  } catch (e) {
    return false;
  }
}
