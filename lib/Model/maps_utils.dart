class MapsUtils{
  static Map<T, R> concatenateMapsIf<T, R>(
    bool condition,
    Map<T, R> m1,
    Map<T, R> m2,
  ) =>
      condition ? concatenateMaps(m1, m2) : m1;

  static Map<T, R> concatenateMaps<T, R>(
    Map<T, R> m1,
    Map<T, R> m2,
  ) {
    m1.addAll(m2);
    return m1;
  }
}