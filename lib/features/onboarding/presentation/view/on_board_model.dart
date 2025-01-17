class OnboardingPage {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

final List<OnboardingPage> pages = [
  OnboardingPage(
    imagePath: 'lib/assets/illustrations/onboarding/tickets.png',
    title: 'Effortless Ticket Booking',
    description: 'Discover the easiest way to buy movie tickets on-the-go.',
  ),
  OnboardingPage(
    imagePath: 'lib/assets/illustrations/onboarding/popcorn.png',
    title: 'Enjoy the Full Experience',
    description: 'Explore movie showtimes, concessions, and more - all in one app.',
  ),
  OnboardingPage(
    imagePath: 'lib/assets/illustrations/onboarding/glasses.png',
    title: 'Plan Your Movie Night',
    description: 'Browse showtimes, purchase tickets, and add events to your calendar - all in a few taps.',
  ),
];