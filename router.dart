import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/patient_care_page.dart';
import 'pages/appointments_page.dart';
import 'pages/academics_page.dart';
import 'pages/admissions_page.dart';
import 'pages/research_page.dart';
import 'pages/contact_page.dart';
import 'pages/hostel_complaint_page.dart';
import 'pages/feedback_page.dart';

final GoRouter appRouter = GoRouter(routes: [
  GoRoute(path: '/',            builder: (c, s) => const HomePage()),
  GoRoute(path: '/about',       builder: (c, s) => const AboutPage()),
  GoRoute(path: '/patient-care',builder: (c, s) => const PatientCarePage()),
  GoRoute(path: '/appointments',builder: (c, s) => const AppointmentsPage()),
  GoRoute(path: '/academics',   builder: (c, s) => const AcademicsPage()),
  GoRoute(path: '/admissions',  builder: (c, s) => const AdmissionsPage()),
  GoRoute(path: '/research',    builder: (c, s) => const ResearchPage()),
  GoRoute(path: '/contact',     builder: (c, s) => const ContactPage()),
  GoRoute(path: '/hostel-complaint', builder: (c, s) => const HostelComplaintPage()),
  GoRoute(path: '/feedback',    builder: (c, s) => const FeedbackPage()),
]);
