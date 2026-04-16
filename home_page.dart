import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/live_ticker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Scaffold(
      appBar: const RRDCHNavbar(),
      body: SingleChildScrollView(
        child: Column(children: [
          const LiveTicker(),
          _HeroSection(isMobile: isMobile),
          _DepartmentFocusSection(),
          _HeritageSection(isMobile: isMobile),
          _EventsSection(),
          _CTASection(),
          const RRDCHFooter(),
        ]),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  const _HeroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 60, vertical: 60),
      child: isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_HeroText(), const SizedBox(height: 32), _HeroImage()])
          : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(child: _HeroText()),
              const SizedBox(width: 40),
              Expanded(child: _HeroImage()),
            ]),
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(text: TextSpan(children: [
        TextSpan(text: 'Curating\n', style: Theme.of(context).textTheme.displayLarge),
        TextSpan(text: 'Excellence\n', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kRed)),
        TextSpan(text: 'in Oral\nHealth.', style: Theme.of(context).textTheme.displayLarge),
      ])),
      const SizedBox(height: 20),
      Text('Bridging heritage with medical precision. RRDCH stands as a beacon of dental innovation, providing world-class education and compassionate patient care since 1992.',
        style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 32),
      Row(children: [
        ElevatedButton(
          onPressed: () => context.go('/admissions'),
          child: const Text('Explore Admissions →'),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () => context.go('/about'),
          icon: const Icon(Icons.play_circle_outline),
          label: const Text('Virtual Tour'),
          style: OutlinedButton.styleFrom(
            foregroundColor: kNavy,
            side: const BorderSide(color: kNavy),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ]),
    ]);
  }
}

class _HeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 380,
        decoration: BoxDecoration(
          color: kOffWhite,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=800'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(bottom: 24, left: 24,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: kGold, borderRadius: BorderRadius.circular(4)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('#1', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
            const Text('TOP DENTAL INSTITUTION', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 0.5)),
          ]),
        ),
      ),
    ]);
  }
}

class _DepartmentFocusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 48),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Department Focus', style: Theme.of(context).textTheme.headlineMedium),
            Text('Specialised pathways for every aspirant and patient.', style: Theme.of(context).textTheme.bodyMedium),
          ]),
          TextButton(onPressed: () {}, child: const Text('View All Departments →', style: TextStyle(color: kNavy))),
        ]),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (_, c) {
          final cols = c.maxWidth > 700 ? 3 : 1;
          return Wrap(spacing: 16, runSpacing: 16, children: [
            _DeptCard(icon: Icons.local_hospital, title: 'Patient Care & Clinical OPD',
              desc: 'Expert dental services spanning all specialities.', isLarge: cols == 3, onTap: () => context.go('/patient-care')),
            _DeptCard(icon: Icons.school, title: 'Student Portal',
              desc: 'Access curriculum, grades, and academic resources.', onTap: () => context.go('/academics')),
            _DeptCard(icon: Icons.science, title: 'Research Hub',
              desc: 'Pioneering breakthroughs in dental sciences.', onTap: () => context.go('/research')),
          ]);
        }),
      ]),
    );
  }
}

class _DeptCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool isLarge;
  final VoidCallback onTap;
  const _DeptCard({required this.icon, required this.title, required this.desc, this.isLarge = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isLarge ? 300 : 220,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isLarge ? kNavy : kWhite,
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: isLarge ? Colors.white70 : kRed, size: 28),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isLarge ? kWhite : kNavy)),
          const SizedBox(height: 8),
          Text(desc, style: TextStyle(fontSize: 13, color: isLarge ? Colors.white60 : kMuted)),
        ]),
      ),
    );
  }
}

class _HeritageSection extends StatelessWidget {
  final bool isMobile;
  const _HeritageSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kOffWhite,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 60, vertical: 60),
      child: isMobile
          ? Column(children: [_HeritageText(), const SizedBox(height: 24), _HeritageImages()])
          : Row(children: [
              Expanded(child: _HeritageText()),
              const SizedBox(width: 40),
              Expanded(child: _HeritageImages()),
            ]),
    );
  }
}

class _HeritageText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Heritage\nMeets\nInnovation', style: Theme.of(context).textTheme.displayMedium),
      Container(width: 40, height: 3, color: kRed, margin: const EdgeInsets.symmetric(vertical: 16)),
      Text('Established with a vision to provide quality education and affordable healthcare, RRDCH has evolved into one of the country\'s premier dental institutions.',
        style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 20),
      _Badge(icon: Icons.verified, label: 'DCI Recognised'),
      const SizedBox(height: 8),
      _Badge(icon: Icons.history, label: '30+ Years Legacy'),
    ]);
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Badge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 18, color: kNavy),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: kNavy)),
    ]);
  }
}

class _HeritageImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: AspectRatio(aspectRatio: 1,
        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1588776814546-1ffedbe47add?w=400'),
            fit: BoxFit.cover))))),
      const SizedBox(width: 12),
      Expanded(child: AspectRatio(aspectRatio: 1,
        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1551601651-2a8555f1a136?w=400'),
            fit: BoxFit.cover))))),
    ]);
  }
}

class _EventsSection extends StatelessWidget {
  final List<Map<String, String>> _events = const [
    {'date': 'MAY 10', 'title': 'Annual Cultural Fest – Chaitanya', 'type': 'Campus Life'},
    {'date': 'MAY 24', 'title': 'Alumni Meet 2026', 'type': 'Alumni'},
    {'date': 'JUN 5',  'title': 'Free Dental Camp – Kumbalgodu', 'type': 'Community'},
    {'date': 'JUN 18', 'title': 'PG Research Symposium', 'type': 'Academic'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 48),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Calendar of Events', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),
        Wrap(spacing: 16, runSpacing: 16, children: _events.map((e) => Container(
          width: 220,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.15)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: kGold, borderRadius: BorderRadius.circular(6)),
              child: Center(child: Text(e['date']!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700), textAlign: TextAlign.center)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e['type']!, style: const TextStyle(fontSize: 10, color: kRed, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
              const SizedBox(height: 2),
              Text(e['title']!, style: const TextStyle(fontSize: 13, color: kNavy, fontWeight: FontWeight.w500)),
            ])),
          ]),
        )).toList()),
      ]),
    );
  }
}

class _CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kNavy,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(children: [
        Text('Ready to shape your future\nin Dentistry?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white)),
        const SizedBox(height: 16),
        Text('Join a community of dedicated professionals and scholars.\nOur admissions for the upcoming cycle are now accepting applications.',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white60, fontSize: 15, height: 1.6)),
        const SizedBox(height: 32),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () => context.go('/admissions'),
            style: ElevatedButton.styleFrom(backgroundColor: kRed),
            child: const Text('Apply Now'),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54)),
            child: const Text('Download Prospectus'),
          ),
        ]),
      ]),
    );
  }
}
