import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';

class RRDCHFooter extends StatelessWidget {
  const RRDCHFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kNavy,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('RRDCH', style: TextStyle(color: kGold, fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('A premier dental education and\nhealthcare hub in Bengaluru.',
              style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.7)),
          ])),
          _FooterCol('Quick Links', [
            _FooterLink('Appointments', '/appointments'),
            _FooterLink('Academics', '/academics'),
            _FooterLink('Research', '/research'),
            _FooterLink('Hostel Complaint', '/hostel-complaint'),
            _FooterLink('Feedback', '/feedback'),
          ]),
          _FooterCol('Compliance', [
            _FooterLink('Privacy Policy', '/'),
            _FooterLink('Anti-Ragging Policy', '/'),
            _FooterLink('IEC Guidelines', '/'),
          ]),
          _FooterCol('Contact Us', []),
        ]),
        const SizedBox(height: 24),
        const Divider(color: Colors.white24),
        const SizedBox(height: 12),
        Text('No.14, Ramohali Cross, Kumbalgodu, Mysore Road, Bengaluru – 560074',
          style: const TextStyle(color: Colors.white54, fontSize: 11)),
        const SizedBox(height: 4),
        Text('© 2026 Rajarajeshwari Dental College & Hospital. All Rights Reserved.',
          style: const TextStyle(color: Colors.white38, fontSize: 11)),
      ]),
    );
  }
}

class _FooterCol extends StatelessWidget {
  final String title;
  final List<_FooterLink> links;
  const _FooterCol(this.title, this.links);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        ...links,
      ]),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final String route;
  const _FooterLink(this.label, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ),
    );
  }
}
