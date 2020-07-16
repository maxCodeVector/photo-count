import 'dart:typed_data';

import 'package:PhotoCount/scrawl/scrawl_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetImageWidget extends StatelessWidget {
  final AssetEntity assetEntity;
  final double width;
  final double height;
  final BoxFit boxFit;

  const AssetImageWidget({
    Key key,
    @required this.assetEntity,
    this.width,
    this.height,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (assetEntity == null) {
      return _buildContainer();
    }

    return InkWell(
      onTap: () => onTap(context),
      child: Container(child: _buildImageThumb()),
    );
  }

  Widget _buildImageThumb() {
    return FutureBuilder<Uint8List>(
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return _buildContainer(
            child: Image.memory(
              snapshot.data,
              width: width,
              height: height,
              fit: boxFit,
            ),
          );
        } else {
          return _buildContainer();
        }
      },
      future: assetEntity.thumbDataWithSize(
        width.toInt(),
        height.toInt(),
      ),
    );
  }

  Widget _buildContainer({Widget child}) {
    child ??= Container();
    return Container(
      width: width,
      height: height,
      child: child,
    );
  }

  onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ScrawlPage(assetEntity);
//          return ImageDraw(assetEntity);
        },
      ),
    );
  }
}
