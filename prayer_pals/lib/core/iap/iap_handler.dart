import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final groupPrayerControllerProvider =
    Provider<IAPHandler>((ref) => IAPHandler());

class IAPHandler {
  final String _kRemovedAdsId = 'com.prayerpals.removeads';
  final String _kStartGroupId = 'com.prayerpals.startgroup';

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  String? _queryProductError;

  Set<String>? _kProductIds;

  IAPHandler() {
    _kProductIds = {
      _kRemovedAdsId,
      _kStartGroupId,
    };
    _init();
  }

  _init() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    _initStoreInfo();
  }

  _initStoreInfo() async {
    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds!);
    if (productDetailResponse.error == null) {
      debugPrint(
          'IAPHandler - ProductDetails: ${productDetailResponse.productDetails}');
      _products = productDetailResponse.productDetails;
    }
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // show success message and deliver the product.
          _purchases.add(purchaseDetails);
        }
      }
    }
  }

  removeAds() {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: _products[0]);
    _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  purchaseGroupAbility() {}
}
