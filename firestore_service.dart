import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  // Appointments
  Future<void> bookAppointment(Map<String, dynamic> data) =>
    _db.collection('appointments').add({...data, 'createdAt': FieldValue.serverTimestamp(), 'status': 'pending'});

  Stream<QuerySnapshot> getAppointments() =>
    _db.collection('appointments').orderBy('createdAt', descending: true).snapshots();

  // Hostel Complaints
  Future<void> submitComplaint(Map<String, dynamic> data) =>
    _db.collection('hostel_complaints').add({...data, 'createdAt': FieldValue.serverTimestamp(), 'status': 'open'});

  // Feedback
  Future<void> submitFeedback(Map<String, dynamic> data) =>
    _db.collection('feedback').add({...data, 'createdAt': FieldValue.serverTimestamp()});

  // Events
  Stream<QuerySnapshot> getEvents() =>
    _db.collection('events').orderBy('date').snapshots();
}
