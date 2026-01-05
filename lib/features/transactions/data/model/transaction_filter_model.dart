import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaction_filter_model.freezed.dart';
part 'transaction_filter_model.g.dart';

@freezed
abstract class TransactionFilter with _$TransactionFilter {
  const factory TransactionFilter({
    String? keyword,
    double? minAmount,
    double? maxAmount,
    String? notes,
    CategoryModel? category,
    TransactionType? transactionType,
    DateTime? dateStart,
    DateTime? dateEnd,
  }) = _TransactionFilter;

  factory TransactionFilter.fromJson(Map<String, dynamic> json) =>
      _$TransactionFilterFromJson(json);
}