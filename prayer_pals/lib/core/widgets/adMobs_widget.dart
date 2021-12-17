// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:prayer_pals/core/utils/ad_helper.dart';

// class AdMobs extends StatefulWidget {
//   const AdMobs({Key? key}) : super(key: key);

//   @override
//   _AdMobsState createState() => _AdMobsState();
// }

// class _AdMobsState extends State<AdMobs> implements Listener {
//   late BannerAd _bannerAd;
//   bool _isBannerAdReady = false;

//   @override
//   void initState() {
//     super.initState();
//     _bannerAd = BannerAd(
//       adUnitId: AdHelper.bannerAdUnitId,
//       request: AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           setState(() {
//             _isBannerAdReady = true;
//           });
//         },
//         onAdFailedToLoad: (ad, err) {
//           print('Failed to load a banner ad: ${err.message}');
//           _isBannerAdReady = false;
//           ad.dispose();
//         },
//       ),
//     );

//     _bannerAd.load();
//   }

//   void dispose() {
//     _bannerAd.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Stack(children: [
//       Center(),
//       if (_isBannerAdReady)
//         Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             width: _bannerAd.size.width.toDouble(),
//             height: _bannerAd.size.height.toDouble(),
//             child: AdWidget(ad: _bannerAd),
//           ),
//         ),
//     ]));
//   }

//   @override
//   // TODO: implement behavior
//   HitTestBehavior get behavior => throw UnimplementedError();

//   @override
//   // TODO: implement child
//   Widget? get child => throw UnimplementedError();

//   @override
//   SingleChildRenderObjectElement createElement() {
//     // TODO: implement createElement
//     throw UnimplementedError();
//   }

//   @override
//   RenderPointerListener createRenderObject(BuildContext context) {
//     // TODO: implement createRenderObject
//     throw UnimplementedError();
//   }

//   @override
//   List<DiagnosticsNode> debugDescribeChildren() {
//     // TODO: implement debugDescribeChildren
//     throw UnimplementedError();
//   }

//   @override
//   void didUnmountRenderObject(covariant RenderObject renderObject) {
//     // TODO: implement didUnmountRenderObject
//   }

//   @override
//   // TODO: implement key
//   Key? get key => throw UnimplementedError();

//   @override
//   // TODO: implement onPointerCancel
//   PointerCancelEventListener? get onPointerCancel => throw UnimplementedError();

//   @override
//   // TODO: implement onPointerDown
//   PointerDownEventListener? get onPointerDown => throw UnimplementedError();

//   @override
//   // TODO: implement onPointerHover
//   PointerHoverEventListener? get onPointerHover => throw UnimplementedError();

//   @override
//   // TODO: implement onPointerMove
//   PointerMoveEventListener? get onPointerMove => throw UnimplementedError();

//   @override
//   // TODO: implement onPointerSignal
//   PointerSignalEventListener? get onPointerSignal => throw UnimplementedError();

//   @override
//   // TODO: implement onPointerUp
//   PointerUpEventListener? get onPointerUp => throw UnimplementedError();

//   @override
//   String toStringDeep(
//       {String prefixLineOne = '',
//       String? prefixOtherLines,
//       DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
//     // TODO: implement toStringDeep
//     throw UnimplementedError();
//   }

//   @override
//   String toStringShallow(
//       {String joiner = ', ',
//       DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
//     // TODO: implement toStringShallow
//     throw UnimplementedError();
//   }

//   @override
//   void updateRenderObject(
//       BuildContext context, covariant RenderPointerListener renderObject) {
//     // TODO: implement updateRenderObject
//   }
// }
