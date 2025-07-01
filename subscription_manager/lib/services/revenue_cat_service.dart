import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:subscription_manager/services/subscription_service.dart';
import '../models/subscription_module.dart';

class RevenueCatService implements SubscriptionService {
  @override
  Future<void> init({required String publicApiKey, String? appUserId}) async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(publicApiKey)..appUserID = appUserId);
  }

  @override
  Future<List<SubscriptionModel>> getAvailablePackages() async {
    final offerings = await Purchases.getOfferings();
    final available = offerings.current?.availablePackages ?? [];
    return available.map((package) {
      final product = package.storeProduct;
      return SubscriptionModel(
        id: package.identifier,
        title: product.title,
        introductoryPrice: product.introductoryPrice,
        priceString: product.priceString,
        description: product.description,
        currencyCode: product.currencyCode,
        price: product.price,
        duration: product.subscriptionPeriod ?? '',
      );
    }).toList();
  }

  @override
  Future<void> purchase(SubscriptionModel package) async {
    final offerings = await Purchases.getOfferings();
    final match = offerings.current?.availablePackages.firstWhere((pkg) => pkg.identifier == package.id, orElse: () => throw Exception('Package not found'));

    if (match != null) {
      await Purchases.purchasePackage(match);
    }
  }

  @override
  Future<bool> isSubscribed() async {
    final customerInfo = await Purchases.getCustomerInfo();
    return customerInfo.entitlements.active.isNotEmpty;
  }

  @override
  Future<void> restorePurchases() async {
    await Purchases.restorePurchases();
  }
}
