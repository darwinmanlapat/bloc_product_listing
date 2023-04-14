import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:product_listing/core/routes/locations/locations.dart';

import 'core/routes/routes.dart';

class ProductListingApp extends HookWidget {
  const ProductListingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerDelegate = useMemoized(() {
      return BeamerDelegate(
        initialPath: ProductsLocation.route,
        locationBuilder: locationBuilder,
        transitionDelegate: const NoAnimationTransitionDelegate(),
        beamBackTransitionDelegate: const NoAnimationTransitionDelegate(),
      );
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
