import 'dart:ui';

class MDLFruitImage {
  String imageUrl;

  MDLFruitImage({required this.imageUrl});

  bool compare(MDLFruitImage mdlRecycle) => mdlRecycle.imageUrl == imageUrl;
}
