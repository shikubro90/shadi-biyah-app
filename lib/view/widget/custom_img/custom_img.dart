import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ImageType {
  png,
  svg,
}

class CustomImage extends StatefulWidget {
  final String imageSrc;
  final Color? imageColor;
  final double? size;
  final ImageType imageType;
  final BoxFit fit;
  final double top;
  final double left;
  final double right;
  final double bottom;

  const CustomImage({
    required this.imageSrc,
    this.imageColor,
    this.size,
    this.imageType = ImageType.svg,
    this.fit = BoxFit.contain,
    super.key,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    if (widget.imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        widget.imageSrc,
        fit: widget.fit,
        // colorFilter: ColorFilter.mode(widget.imageColor!, BlendMode.srcIn),
        height: widget.size,
        width: widget.size,
      );
    }

    if (widget.imageType == ImageType.png) {
      imageWidget = Image.asset(
        fit: widget.fit,
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.size,
        width: widget.size,
      );
    }

    return Container(
        margin: EdgeInsets.only(
            top: widget.top,
            bottom: widget.bottom,
            left: widget.left,
            right: widget.right),
        height: widget.size,
        width: widget.size,
        child: imageWidget);
  }
}
