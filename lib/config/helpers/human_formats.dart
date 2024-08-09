import 'package:intl/intl.dart';

class HumanFormats {
  // al hacerlo static no tenemos que crear una instancia para llamar uno de sus metodos

  static String humanReadableNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);
    return formatterNumber;
  }
}
