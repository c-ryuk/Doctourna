import 'package:flutter/material.dart';
import 'package:tbibi/models/location.dart';
import 'package:tbibi/services/get_doctor_data.dart';
import 'package:tbibi/services/location_service.dart';
import 'package:tbibi/widgets/location_widget.dart';

import 'location_loader.dart';

class LocationBuilder extends StatefulWidget {
  @override
  State<LocationBuilder> createState() => _LocationBuilderState();
}

class _LocationBuilderState extends State<LocationBuilder> {
  LocationService serv = LocationService();
  var future;
  @override
  void initState() {
    super.initState();
    future = serv.getPermession();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LocationModel locationModel = snapshot.data as LocationModel;
            DocData().setLocation(
                gouvernorat:
                    '${locationModel.governorat}, ${locationModel.locality}');
            return LocationWidget(location: locationModel);
          } else {
            return LocationLoader();
          }
        });
  }
}
