class CategoriesIcons {
  final List<String> categoryIcons = List.generate(
    24,
    (index) => 'lib/core/assets/categories/${index + 1}.png',
  );
}
