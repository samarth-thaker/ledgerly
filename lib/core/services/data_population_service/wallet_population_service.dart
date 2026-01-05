import 'package:ledgerly/core/database/ledgerly_database.dart';
import 'package:ledgerly/core/utils/logger.dart';
import 'package:ledgerly/features/wallets/data/repo/wallet_repo.dart';

class WalletPopulationService {
  static Future<void> populate(AppDatabase db) async {
    Log.i('Populating default wallets...', label: 'wallet');
    for (final walletModel in defaultWallets) {
      try {
        await db.walletDao.addWallet(walletModel);
        Log.d(
          'Successfully added default wallet: ${walletModel.name}',
          label: 'wallet',
        );
      } catch (e) {
        Log.e(
          'Failed to add default wallet ${walletModel.name}: $e',
          label: 'wallet',
        );
      }
    }

    Log.i(
      'Default wallets populated successfully: (${defaultWallets.length})',
      label: 'wallet',
    );
  }
}