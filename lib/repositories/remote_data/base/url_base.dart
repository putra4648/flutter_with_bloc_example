class BaseUri {
  static final instance = BaseUri();

  String searchUri = 'https://www.themealdb.com/api/json/v1/1/search.php?s=<?>';
  String recipesDetailUri =
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=<?>';
  String randomUri = 'https://www.themealdb.com/api/json/v1/1/random.php';
}
