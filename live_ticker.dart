import 'package:flutter/material.dart';
import '../theme.dart';

class LiveTicker extends StatelessWidget {
  const LiveTicker({super.key});

  static const List<String> _updates = [
    'Admissions Open for Academic Year 2026-27',
    'International Conference on Dental Dentistry – next month',
    'Free Dental Screening Camp in South Bengaluru',
    'New Maxillofacial Surgery Department launched',
    'Alumni Meet 2026 – Register now',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: kNavy,
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: kRed,
          child: const Text('LIVE UPDATES',
            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ScrollingTicker(items: _updates),
        ),
      ]),
    );
  }
}

class _ScrollingTicker extends StatefulWidget {
  final List<String> items;
  const _ScrollingTicker({required this.items});
  @override State<_ScrollingTicker> createState() => _ScrollingTickerState();
}

class _ScrollingTickerState extends State<_ScrollingTicker> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 30))..repeat();
    _anim = Tween<double>(begin: 1.0, end: -3.0).animate(_ctrl);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final text = widget.items.join('   •   ');
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => FractionalTranslation(
        translation: Offset(_anim.value, 0),
        child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11), maxLines: 1),
      ),
    );
  }
}
