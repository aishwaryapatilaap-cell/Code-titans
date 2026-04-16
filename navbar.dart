import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';

class RRDCHNavbar extends StatefulWidget implements PreferredSizeWidget {
  const RRDCHNavbar({super.key});
  @override Size get preferredSize => const Size.fromHeight(64);
  @override State<RRDCHNavbar> createState() => _RRDCHNavbarState();
}

class _RRDCHNavbarState extends State<RRDCHNavbar> {
  bool _isKannada = false;

  final Map<String, String> _labels = {
    'Academics': 'ಶೈಕ್ಷಣಿಕ',
    'Patient Care': 'ರೋಗಿ ಆರೈಕೆ',
    'Research': 'ಸಂಶೋಧನೆ',
    'Hospital': 'ಆಸ್ಪತ್ರೆ',
    'Admissions': 'ಪ್ರವೇಶ',
    'Contact': 'ಸಂಪರ್ಕ',
  };

  final List<Map<String, String>> _navItems = [
    {'label': 'Academics',   'route': '/academics'},
    {'label': 'Patient Care','route': '/patient-care'},
    {'label': 'Research',    'route': '/research'},
    {'label': 'Admissions',  'route': '/admissions'},
    {'label': 'Contact',     'route': '/contact'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 24,
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text('RAJARAJESHWARI', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kNavy, letterSpacing: 1)),
          Text('Dental College & Hospital', style: TextStyle(fontSize: 10, color: kMuted)),
        ]),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(height: 0.5, color: Colors.grey.withOpacity(0.2)),
      ),
      actions: [
        if (!isMobile) ..._navItems.map((item) => TextButton(
          onPressed: () => context.go(item['route']!),
          child: Text(
            _isKannada ? (_labels[item['label']] ?? item['label']!) : item['label']!,
            style: const TextStyle(fontSize: 13, color: kNavy),
          ),
        )),
        TextButton(
          onPressed: () => setState(() => _isKannada = !_isKannada),
          child: Text(_isKannada ? 'English' : 'ಕನ್ನಡ',
            style: const TextStyle(fontSize: 13, color: kNavy, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 12),
        if (isMobile) IconButton(
          icon: const Icon(Icons.menu, color: kNavy),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }
}
