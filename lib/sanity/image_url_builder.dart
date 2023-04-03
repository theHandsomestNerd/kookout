import 'package:cookout/sanity/sanity_client.dart';
import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

class MyImageBuilder {
  late ImageUrlBuilder builder;

  MyImageBuilder(){
    var theSanityClient = sanityClient();
    builder = ImageUrlBuilder(theSanityClient);
  }

  ImageUrlBuilder? urlFor(SanityImage? asset, int? height,int? width) {
    if(asset == null) {
      return null;
    }

    var theBuilder = builder.image(asset);
    if(height != null) {
      theBuilder.height(height);
    }
    if(width != null) {
      theBuilder.width(width);
    }

    return theBuilder;
  }
}
