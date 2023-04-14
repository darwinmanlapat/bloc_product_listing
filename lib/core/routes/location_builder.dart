import 'package:beamer/beamer.dart';
import 'package:product_listing/core/routes/locations/locations.dart';

final locationBuilder = BeamerLocationBuilder(
  beamLocations: [
    ProductsLocation(),
    ProductLocation(),
  ],
);
