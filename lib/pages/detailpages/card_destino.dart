import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';

class OverlayChegada extends StatefulWidget {
  final String titulo;
  final bool isDark;
  final VoidCallback onClose;

  const OverlayChegada({
    super.key,
    required this.titulo,
    required this.isDark,
    required this.onClose,
  });

  @override
  State<OverlayChegada> createState() => _OverlayChegadaState();
}

class _OverlayChegadaState extends State<OverlayChegada>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, -0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Fecha automaticamente após 5 segundos
    Future.delayed(const Duration(seconds: 5), () async {
      await _controller.reverse();
      if (mounted) widget.onClose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark
        ? AppThemeDark.curvedButton
        : AppThemeLight.curvedButton;
    final textColor = widget.isDark
        ? AppThemeDark.curvedIconSelected
        : AppThemeLight.curvedIconSelected;

    return IgnorePointer(
      ignoring: true, // deixa passar interação para o mapa
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _slideAnim,
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        "Você chegou em ${widget.titulo}!",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
