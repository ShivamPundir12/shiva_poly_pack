import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shiva_poly_pack/material/responsive.dart';
import 'package:shiva_poly_pack/material/styles.dart';

class EnhancedHomeCard extends StatefulWidget {
  final String icon;
  final String title;
  final Color backgroundColor;
  final VoidCallback onTap;

  const EnhancedHomeCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<EnhancedHomeCard> createState() => _EnhancedHomeCardState();
}

class _EnhancedHomeCardState extends State<EnhancedHomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI _ui = ResponsiveUI(context);

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color:
                    widget.backgroundColor.withOpacity(_isHovered ? 0.3 : 0.2),
                blurRadius: _isHovered ? 20 : 15,
                offset: Offset(0, _isHovered ? 10 : 8),
                spreadRadius: _isHovered ? 2 : 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  right: _isHovered ? -15 : -20,
                  top: _isHovered ? -15 : -20,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.backgroundColor
                          .withOpacity(_isHovered ? 0.15 : 0.1),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: _isHovered ? -10 : -15,
                  bottom: _isHovered ? -10 : -15,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.backgroundColor
                          .withOpacity(_isHovered ? 0.2 : 0.15),
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: EdgeInsets.all(_ui.widthPercent(4)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(_ui.widthPercent(3)),
                        decoration: BoxDecoration(
                          color: widget.backgroundColor
                              .withOpacity(_isHovered ? 0.15 : 0.1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: _isHovered
                              ? [
                                  BoxShadow(
                                    color:
                                        widget.backgroundColor.withOpacity(0.2),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : [],
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: Matrix4.identity()
                            ..scale(_isHovered ? 1.05 : 1.0),
                          child: SvgPicture.asset(
                            widget.icon,
                            height: _ui.heightPercent(5),
                            width: _ui.widthPercent(8),
                            color: widget.backgroundColor,
                          ),
                        ),
                      ),
                      SizedBox(height: _ui.heightPercent(2)),
                      Container(
                        alignment: Alignment.center,
                        width: _ui.widthPercent(50),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: Styles.getstyle(
                            fontweight:
                                _isHovered ? FontWeight.bold : FontWeight.w600,
                            fontsize: _ui.widthPercent(_isHovered ? 4.2 : 4),
                            fontcolor: Colors.black87,
                          ),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
