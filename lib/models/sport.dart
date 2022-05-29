enum Sport {
  football,
  handball,
  basketball,
  tennis,
  baseball,
  volleyball,
  badminton,
  boxing,
  tableTennis,
  rugby,
  surfing,
  snowboarding,
  skateboarding,
  cycling,
  archery,
  gymnastics,
  rollerSkating;

  @override
  String toString() {
    final spacedName =
        name.replaceAllMapped(RegExp(r'[A-Z]'), (m) => ' ${m.group(0)}');
    return spacedName
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
