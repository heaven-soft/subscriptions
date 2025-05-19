class SubscriptionModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String priceString;
  final String currencyCode;
  final String? duration;

  SubscriptionModel({
    required this.id,
    required this.title,
    required this.priceString,
    required this.description,
    required this.currencyCode,
    required this.price,
    this.duration,
  });
}