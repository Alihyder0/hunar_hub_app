import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsets padding;
  final double borderRadius;
  final bool expand;

  const GradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
    this.borderRadius = 22,
    this.expand = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  final GlobalKey _inkKey = GlobalKey();
  bool _isHovering = false;
  Offset _hoverOffset = Offset.zero;

  void _handleEnter(PointerEnterEvent event) {
    setState(() => _isHovering = true);
  }

  void _handleHover(PointerHoverEvent event) {
    if (!_isHovering) return;
    final renderBox = _inkKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;
    if (size.isEmpty) return;
    final normalizedX = (event.localPosition.dx / size.width).clamp(0.0, 1.0) - 0.5;
    final normalizedY = (event.localPosition.dy / size.height).clamp(0.0, 1.0) - 0.5;
    const travel = 12.0;
    setState(() {
      _hoverOffset = Offset(normalizedX * travel, normalizedY * travel);
    });
  }

  void _handleExit(PointerExitEvent event) {
    if (!_isHovering) return;
    setState(() {
      _isHovering = false;
      _hoverOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: widget.expand ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        if (widget.trailing != null) ...[
          const SizedBox(width: 8),
          widget.trailing!,
        ]
      ],
    );

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Ink(
          key: _inkKey,
          padding: widget.padding,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2AB1A6), Color(0xFFE07B58)],
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: const Color(0x26000000),
                blurRadius: _isHovering ? 26 : 18,
                offset: Offset(0, _isHovering ? 14 : 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _handleEnter,
      onHover: _handleHover,
      onExit: _handleExit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(_hoverOffset.dx, _hoverOffset.dy),
        child: AnimatedScale(
          scale: _isHovering ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: button,
        ),
      ),
    );
  }
}
