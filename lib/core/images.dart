import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Shrinks a picked logo so invoices and backups stay small. Returns null when
/// the bytes are not an image.
Uint8List? normalizeImage(Uint8List bytes, {int maxWidth = 512}) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  final resized = decoded.width > maxWidth ? img.copyResize(decoded, width: maxWidth) : decoded;
  return Uint8List.fromList(img.encodePng(resized));
}
