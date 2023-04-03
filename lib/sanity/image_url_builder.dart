import 'package:cookout/sanity/sanity_client.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

class MyImageBuilder {
  late ImageUrlBuilder builder;

  MyImageBuilder(){
    var theSanityClient = sanityClient();
    builder = ImageUrlBuilder(theSanityClient);
  }

  ImageUrlBuilder? urlFor(asset) {
    if(asset == null) {
      return null;
    }
    return builder.image(asset);
  }
}
