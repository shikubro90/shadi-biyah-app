import 'package:flutter/material.dart';

class AnimatedExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  final int duration;
  const AnimatedExpandedSection(
      {Key? key, this.expand = false, required this.child, this.duration = 500})
      : super(key: key);

  @override
  State<AnimatedExpandedSection> createState() =>
      _AnimatedExpandedSectionState();
}

class _AnimatedExpandedSectionState extends State<AnimatedExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(AnimatedExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
