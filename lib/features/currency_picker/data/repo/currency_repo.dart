import 'package:ledgerly/features/currency_picker/data/models/currency.dart';
import 'package:ledgerly/features/currency_picker/data/source/currency_data_source.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> fetchCurrencies();
}

class CurrencyRepositoryImpl implements CurrencyRepository {
  @override
  Future<List<Currency>> fetchCurrencies() async {
    final localDataSource = CurrencyLocalDataSource();
    final currencies = await localDataSource.getCurrencies();
    return currencies
        .map((jsonObject) => Currency.fromJson(jsonObject))
        .toList();
  }
}