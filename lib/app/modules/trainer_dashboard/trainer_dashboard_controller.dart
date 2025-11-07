import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerDashboardController extends GetxController {
  final List<DashboardStatData> stats = const [
    DashboardStatData(
      title: 'Active Students',
      value: '56',
      change: '+12% vs last month',
      icon: Icons.people_alt_rounded,
      iconColor: Color(0xFF2F855A),
      backgroundColor: Color(0xFFE9F6F0),
    ),
    DashboardStatData(
      title: 'Courses',
      value: '5',
      change: '2 in review',
      icon: Icons.menu_book_rounded,
      iconColor: Color(0xFF9C4221),
      backgroundColor: Color(0xFFFBEAE3),
    ),
    DashboardStatData(
      title: 'Avg Rating',
      value: '4.8',
      change: 'Based on 248 reviews',
      icon: Icons.star_rounded,
      iconColor: Color(0xFF744210),
      backgroundColor: Color(0xFFFDF6E3),
    ),
    DashboardStatData(
      title: 'Revenue',
      value: 'PKR 96,800',
      change: 'This month',
      icon: Icons.query_stats_rounded,
      iconColor: Color(0xFF285E61),
      backgroundColor: Color(0xFFE6F6F8),
    ),
  ];

  final List<TrainerCourseData> courses = const [
    TrainerCourseData(
      title: 'Traditional Pakistani Embroidery',
      category: 'Textile Arts',
      price: 'PKR 9,500',
      learners: 342,
      rating: 4.9,
      completion: 0.78,
      accentColor: Color(0xFF9D4EDD),
      icon: Icons.style_rounded,
      primaryActionLabel: 'Go Live',
      secondaryActionLabel: 'See Stats',
    ),
    TrainerCourseData(
      title: 'Advanced Embroidery Techniques',
      category: 'Skill Boost',
      price: 'PKR 11,200',
      learners: 215,
      rating: 4.7,
      completion: 0.62,
      accentColor: Color(0xFF2D6A4F),
      icon: Icons.auto_fix_high_rounded,
      primaryActionLabel: 'See Stats',
      secondaryActionLabel: 'Edit',
    ),
    TrainerCourseData(
      title: 'Watercolor & Calligraphy',
      category: 'Creative Arts',
      price: 'PKR 8,300',
      learners: 168,
      rating: 4.6,
      completion: 0.44,
      accentColor: Color(0xFF0083B0),
      icon: Icons.brush_rounded,
      primaryActionLabel: 'Set Live',
      secondaryActionLabel: 'Preview',
    ),
  ];

  final List<RecentEnrollmentData> recentEnrollments = const [
    RecentEnrollmentData(
      learnerName: 'Ayesha Khan',
      courseTitle: 'Traditional Embroidery',
      enrolledAgo: '12m ago',
      status: 'Paid',
      statusColor: Color(0xFF2F855A),
    ),
    RecentEnrollmentData(
      learnerName: 'Minal Ali',
      courseTitle: 'Advanced Techniques',
      enrolledAgo: '45m ago',
      status: 'Pending',
      statusColor: Color(0xFFE07628),
    ),
    RecentEnrollmentData(
      learnerName: 'Rida Saeed',
      courseTitle: 'Watercolor & Calligraphy',
      enrolledAgo: '1h ago',
      status: 'Paid',
      statusColor: Color(0xFF2F855A),
    ),
    RecentEnrollmentData(
      learnerName: 'Mahnoor Yusuf',
      courseTitle: 'Beginner Embroidery',
      enrolledAgo: '2h ago',
      status: 'Refunded',
      statusColor: Color(0xFF9B2C2C),
    ),
  ];

  String get greeting => 'Good afternoon, Trainer!';

  String get subGreeting => 'Your students are eager to learn. Let’s get started.';
}

class DashboardStatData {
  const DashboardStatData({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
}

class TrainerCourseData {
  const TrainerCourseData({
    required this.title,
    required this.category,
    required this.price,
    required this.learners,
    required this.rating,
    required this.completion,
    required this.accentColor,
    required this.icon,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
  });

  final String title;
  final String category;
  final String price;
  final int learners;
  final double rating;
  final double completion;
  final Color accentColor;
  final IconData icon;
  final String primaryActionLabel;
  final String secondaryActionLabel;
}

class RecentEnrollmentData {
  const RecentEnrollmentData({
    required this.learnerName,
    required this.courseTitle,
    required this.enrolledAgo,
    required this.status,
    required this.statusColor,
  });

  final String learnerName;
  final String courseTitle;
  final String enrolledAgo;
  final String status;
  final Color statusColor;
}
