import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../services/firestore_service.dart';

class HostelComplaintPage extends StatefulWidget {
  const HostelComplaintPage({super.key});
  @override State<HostelComplaintPage> createState() => _HostelComplaintPageState();
}

class _HostelComplaintPageState extends State<HostelComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _roomNo = TextEditingController();
  final _complaint = TextEditingController();
  String _category = 'Maintenance';
  bool _submitted = false;

  final List<String> _cats = ['Maintenance','Food','Security','Cleanliness','Wi-Fi','Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RRDCHNavbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          Text('Hostel Complaint System', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text('Submit your complaint anonymously or with your details.', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          if (_submitted)
            _SuccessMsg()
          else ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(controller: _name, decoration: _dec('Your Name (optional)', Icons.person)),
                const SizedBox(height: 16),
                TextFormField(controller: _roomNo, decoration: _dec('Room Number', Icons.door_back_door), validator: (v) => v!.isEmpty ? 'Required' : null),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _category,
                  items: _cats.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) => setState(() => _category = v!),
                  decoration: _dec('Category', Icons.category),
                ),
                const SizedBox(height: 16),
                TextFormField(controller: _complaint, maxLines: 5, decoration: _dec('Describe your complaint', Icons.description), validator: (v) => v!.isEmpty ? 'Required' : null),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    await FirestoreService().submitComplaint({'name': _name.text, 'roomNo': _roomNo.text, 'category': _category, 'complaint': _complaint.text});
                    setState(() => _submitted = true);
                  },
                  child: const Text('Submit Complaint'),
                )),
              ]),
            ),
          ),
          const SizedBox(height: 60),
          const RRDCHFooter(),
        ]),
      ),
    );
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: kNavy),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: kNavy), borderRadius: BorderRadius.circular(4)),
  );
}

class _SuccessMsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
    child: const Column(children: [
      Icon(Icons.check_circle, color: Color(0xFF388E3C), size: 56),
      SizedBox(height: 12),
      Text('Complaint Submitted', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      SizedBox(height: 8),
      Text('Your complaint has been logged. The hostel warden will respond within 48 hours.', textAlign: TextAlign.center),
    ]),
  );
}
