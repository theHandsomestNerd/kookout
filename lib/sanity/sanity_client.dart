import 'package:cookout/config/api_options.dart';
import 'package:flutter_sanity/flutter_sanity.dart';

final sanityClient = SanityClient(
  dataset: DefaultAppOptions.currentPlatform.sanityDB,
  projectId: 'dhhk6mar',
);