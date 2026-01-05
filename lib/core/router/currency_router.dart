import 'package:go_router/go_router.dart';
import 'package:ledgerly/core/router/routes.dart';
import 'package:ledgerly/features/currency_picker/currency_list_tiles.dart';
class CurrencyRouter {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.currencyListTile,
      builder: (context, state) => const CurrencyListTiles(),
    ),
  ];
}