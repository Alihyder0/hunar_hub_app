class Course {
  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.progress,
    required this.color,
    required this.description,
    required this.lessons,
  });

  final String id;
  final String title;
  final String category;
  final String duration;
  final double progress;
  final int lessons;
  final int color;
  final String description;
}

const sampleCourses = <Course>[
  Course(
    id: 'course-ux-design',
    title: 'Product Design Masterclass',
    category: 'UX Design',
    duration: '24h',
    progress: 0.68,
    lessons: 18,
    color: 0xFF2AB1A6,
    description:
        'Master the end-to-end design process with immersive case studies, motion handoffs, and user testing frameworks tailored for mobile experiences.',
  ),
  Course(
    id: 'course-animation',
    title: 'Motion Graphics for Apps',
    category: 'Animation',
    duration: '16h',
    progress: 0.35,
    lessons: 12,
    color: 0xFFFCB62B,
    description:
        'Bring your UI concepts to life with micro-interactions, animated illustrations, and delightful onboarding flows crafted in After Effects and Rive.',
  ),
  Course(
    id: 'course-branding',
    title: 'Brand Identity Sprint',
    category: 'Branding',
    duration: '12h',
    progress: 0.12,
    lessons: 9,
    color: 0xFF5C5BEB,
    description:
        'Explore typography systems, color psychology, and design tokens while building a cohesive brand experience for multi-platform products.',
  ),
];
