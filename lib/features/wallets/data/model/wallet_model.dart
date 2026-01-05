import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledgerly/features/currency_picker/data/models/currency.dart';
import 'package:ledgerly/features/currency_picker/data/source/currency_data_source.dart';
import 'package:ledgerly/features/currency_picker/presentation/riverpod/currency_picker_provider.dart';
part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

/// Represents a user's wallet or financial account.
@freezed
abstract class WalletModel with _$WalletModel {
  const factory WalletModel({
    /// The unique identifier for the wallet.
    int? id,

    /// The identifier of the user who owns this wallet.
    int? userId,

    /// The name of the wallet (e.g., "Primary Checking", "Savings").
    @Default('My Wallet') String name,

    /// The current balance of the wallet.
    @Default(0.0) double balance,

    /// The currency code for the wallet's balance (e.g., "USD", "EUR", "NGN").
    @Default('IDR') String currency,

    /// Optional: The identifier or name of the icon associated with this wallet.
    String? iconName,

    /// Optional: The color associated with this wallet, stored as a hex string or int.
    String? colorHex, // Or int colorValue
  }) = _WalletModel;

  /// Creates a `WalletModel` instance from a JSON map.
  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  String get name => null;

  get currency => null;

  get balance => null;

  int? get id => null;

  String? get iconName => null;

  String? get colorHex => null;

  toJson() {}
}

/// Utility extensions for the [WalletModel].
extension WalletModelUtils on WalletModel {
  String get formattedBalance {
    return '$currency ${balance.toPriceFormat()}';
  }

  Currency currencyByIsoCode(WidgetRef ref) {
    final currencies = ref.read(currenciesStaticProvider);
    return currencies.fromIsoCode(currency) ?? CurrencyLocalDataSource.dummy;
  }
}