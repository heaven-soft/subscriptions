import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';

import '../models/subscription_module.dart';

abstract class SubscriptionService {
  Future<void> init({required String publicApiKey, String? appUserId});
  Future<List<SubscriptionModel>> getAvailablePackages();
  Future<void> purchase(SubscriptionModel package);
  Future<bool> isSubscribed();
  Future<List<EntitlementInfo>> getActiveSubscriptions();
  Future<void> restorePurchases();
}