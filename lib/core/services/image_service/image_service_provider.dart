
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgerly/core/services/image_service/image_service.dart';

/// Provider for the [ImageService]
final imageServiceProvider = Provider<ImageService>((ref) {
  return ImageService();
});
