import 'package:chat_line/sanity/sanity_client.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

class MyImageBuilder {
  final builder = ImageUrlBuilder(sanityClient);

  ImageUrlBuilder? urlFor(asset) {
    if(asset == null) {
      return null;
    }
    return builder.image(asset);
  }
}
