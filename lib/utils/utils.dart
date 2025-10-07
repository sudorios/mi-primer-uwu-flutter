class Utils {
  static String invertirNombre(String nombre) {
    return nombre.split('').reversed.join();
  }

 static int sumaDigitosImpares(int numero) {
    int suma = 0;
    String numStr = numero.abs().toString();
    for (var char in numStr.split('')) {
      int digito = int.parse(char);
      if (digito % 2 != 0) {
        suma += digito;
      }
    }
    return suma;
  }

  static bool esPalindromo(String texto) {
    String limpio = texto.replaceAll(' ', '').toLowerCase();
    return limpio == limpio.split('').reversed.join();
  }

  static int factorial(int n) {
    if (n < 0) throw ArgumentError('No existe factorial de negativos');
    int resultado = 1;
    for (int i = 1; i <= n; i++) {
      resultado *= i;
    }
    return resultado;
  }

  static List<int> fibonacci(int n) {
    if (n <= 0) return [];
    if (n == 1) return [0];
    List<int> serie = [0, 1];
    for (int i = 2; i < n; i++) {
      serie.add(serie[i - 1] + serie[i - 2]);
    }
    return serie;
  }

  static int contarDigitos(int numero) {
    return numero.abs().toString().length;
  }

  static int sumaDigitos(int numero) {
    return numero
        .abs()
        .toString()
        .split('')
        .map((e) => int.parse(e))
        .reduce((a, b) => a + b);
  }

  static int invertirNumero(int numero) {
    String invertido = numero.abs().toString().split('').reversed.join();
    return int.parse(invertido) * (numero < 0 ? -1 : 1);
  }

  static bool esPrimo(int numero) {
    if (numero <= 1) return false;
    for (int i = 2; i <= numero ~/ 2; i++) {
      if (numero % i == 0) return false;
    }
    return true;
  }

  static int sumaHastaN(int n) {
    if (n < 0) throw ArgumentError('n debe ser positivo');
    return (n * (n + 1)) ~/ 2;
  }

  static int cuadrado(int n) => n * n;

  static int cubo(int n) => n * n * n;

  static bool esPar(int n) => n % 2 == 0;

  static bool esImpar(int n) => n % 2 != 0;

  static int sumaFactores(int n) {
    if (n <= 0) return 0;
    int suma = 0;
    for (int i = 1; i <= n; i++) {
      if (n % i == 0) suma += i;
    }
    return suma;
  }

  static int contarVocales(String texto) {
    final vocales = RegExp(r'[aeiouáéíóúAEIOUÁÉÍÓÚ]');
    return vocales.allMatches(texto).length;
  }

  static bool soloLetras(String texto) {
    return RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$').hasMatch(texto);
  }

  static String invertirMayus(String texto) {
    return texto.toUpperCase().split('').reversed.join();
  }
}

