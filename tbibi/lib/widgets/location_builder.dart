import 'package:flutter/material.dart';
import 'package:tbibi/services/location_service.dart';
import 'package:tbibi/widgets/location_widget.dart';

import 'location_loader.dart';

class LocationBuilder extends StatefulWidget {
  @override
  State<LocationBuilder> createState() => _LocationBuilderState();
}

class _LocationBuilderState extends State<LocationBuilder> {
  LocationService serv = LocationService();
  @override
  void initState() {
    super.initState();
    serv.getPermession();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: serv.getPermession(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LocationWidget(location: snapshot.data);
          } else {
            return LocationLoader();
          }
        });
  }
}
