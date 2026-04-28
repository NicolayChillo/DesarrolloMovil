class PruebaModel {
  static int sumSerie(int num){
    int suma = 0;
    for (int i = 1; i <= num; i++) {
      suma += (i % 2 == 1) ? i : i + 3;
    }
    return suma;
  }
}