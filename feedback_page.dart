import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../services/firestore_service.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  @override State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _msg = TextEditingController();
  int _rating = 5;
  String _type = 'Patient';
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RRDCHNavbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          Text('Share Your Feedback', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 32),
          if (_submitted)
            const Text('Thank you for your feedback!', style: TextStyle(fontSize: 20, color: Colors.green))
          else ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(key: _formKey, child: Column(children: [
              TextFormField(controller: _name, decoration: InputDecoration(labelText: 'Your Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))), validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(value: _type, items: ['Patient','Student','Faculty','Visitor'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => setState(() => _type = v!), decoration: InputDecoration(labelText: 'I am a', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)))),
              const SizedBox(height: 16),
              Row(children: [const Text('Rating: '), ...List.generate(5, (i) => IconButton(icon: Icon(i < _rating ? Icons.star : Icons.star_border, color: kGold), onPressed: () => setState(() => _rating = i + 1)))]),
              const SizedBox(height: 16),
              TextFormField(controller: _msg, maxLines: 4, decoration: InputDecoration(labelText: 'Your Feedback', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))), validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, child: ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  await FirestoreService().submitFeedback({'name': _name.text, 'type': _type, 'rating': _rating, 'message': _msg.text});
                  setState(() => _submitted = true);
                },
                child: const Text('Submit Feedback'),
              )),
            ])),
          ),
          const SizedBox(height: 60),
          const RRDCHFooter(),
        ]),
      ),
    );
  }
}
