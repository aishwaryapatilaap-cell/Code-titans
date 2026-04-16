import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../services/firestore_service.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});
  @override State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  String _dept = 'General Dentistry';
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  bool _submitted = false;
  bool _loading = false;

  final List<String> _depts = ['General Dentistry','Orthodontics','Oral Surgery','Periodontics','Pedodontics','Prosthodontics','Endodontics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RRDCHNavbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          Text('Book an Appointment', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text('Fill the form below and our team will confirm your slot.', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          if (_submitted) _SuccessCard()
          else _buildForm(),
          const SizedBox(height: 60),
          const RRDCHFooter(),
        ]),
      ),
    );
  }

  Widget _buildForm() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Form(
        key: _formKey,
        child: Column(children: [
          _field('Full Name', _name, Icons.person),
          const SizedBox(height: 16),
          _field('Phone Number', _phone, Icons.phone, type: TextInputType.phone),
          const SizedBox(height: 16),
          _field('Email Address', _email, Icons.email, type: TextInputType.emailAddress),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _dept,
            items: _depts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
            onChanged: (v) => setState(() => _dept = v!),
            decoration: _inputDecor('Department', Icons.local_hospital),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today, color: kNavy),
            title: Text('Preferred Date: ${_date.day}/${_date.month}/${_date.year}'),
            trailing: TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                );
                if (picked != null) setState(() => _date = picked);
              },
              child: const Text('Change'),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: _loading ? null : _submit,
            child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Book Appointment'),
          )),
        ]),
      ),
    );
  }

  InputDecoration _inputDecor(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: kNavy),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: kNavy), borderRadius: BorderRadius.circular(4)),
  );

  Widget _field(String label, TextEditingController ctrl, IconData icon, {TextInputType? type}) =>
    TextFormField(
      controller: ctrl,
      keyboardType: type,
      validator: (v) => v!.isEmpty ? 'Required' : null,
      decoration: _inputDecor(label, icon),
    );

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await FirestoreService().bookAppointment({
      'name': _name.text, 'phone': _phone.text,
      'email': _email.text, 'department': _dept,
      'preferredDate': _date.toIso8601String(),
    });
    setState(() { _loading = false; _submitted = true; });
  }
}

class _SuccessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4CAF50)),
      ),
      child: Column(children: [
        const Icon(Icons.check_circle, color: Color(0xFF388E3C), size: 56),
        const SizedBox(height: 16),
        const Text('Appointment Booked!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF1B5E20))),
        const SizedBox(height: 8),
        const Text('We have received your request. Our team will contact you shortly to confirm your appointment slot.', textAlign: TextAlign.center),
      ]),
    );
  }
}
