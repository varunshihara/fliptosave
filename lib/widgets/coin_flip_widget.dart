import 'dart:math';
import 'package:flutter/material.dart';

class CoinFlipWidget extends StatefulWidget {
  final VoidCallback? onFlipComplete;
  final bool isFlipping;

  const CoinFlipWidget({Key? key, this.onFlipComplete, this.isFlipping = false})
    : super(key: key);

  @override
  State<CoinFlipWidget> createState() => _CoinFlipWidgetState();
}

class _CoinFlipWidgetState extends State<CoinFlipWidget>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late AnimationController _bounceController;
  late Animation<double> _flipAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _flipAnimation =
        Tween<double>(
          begin: 0.0,
          end: 8.0, // Number of flips
        ).animate(
          CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
        );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bounceController.forward().then((_) {
          _bounceController.reverse().then((_) {
            widget.onFlipComplete?.call();
          });
        });
      }
    });
  }

  @override
  void didUpdateWidget(CoinFlipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipping && !oldWidget.isFlipping) {
      _startFlip();
    }
  }

  void _startFlip() {
    _flipController.reset();
    _bounceController.reset();
    _flipController.forward();
  }

  @override
  void dispose() {
    _flipController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_flipAnimation, _bounceAnimation]),
        builder: (context, child) {
          final flip = _flipAnimation.value;
          final bounce = _bounceAnimation.value;

          return Transform.scale(
            scale: bounce,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(flip * pi),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.amber.shade300,
                      Colors.amber.shade600,
                      Colors.amber.shade800,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '₹',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
