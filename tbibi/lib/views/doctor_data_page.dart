import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tbibi/models/country.dart';
import 'package:tbibi/widgets/country_widget.dart';

class DoctorDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 28,
                )),
            Text(
              " Validation",
              style: TextStyle(fontFamily: 'Poppins Medium', fontSize: 27),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Finish",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
          )
        ],
      ),
      body: Column(
        children: [
          Text(
            "Where are you from ?",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CountryWidget(
                    country: Country(
                  title: "Tunisia",
                  flag: CountryFlag.fromCountryCode(
                    'TN',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "Argentina",
                  flag: CountryFlag.fromCountryCode(
                    'AR',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "France",
                  flag: CountryFlag.fromCountryCode(
                    'FR',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "Canada",
                  flag: CountryFlag.fromCountryCode(
                    'CA',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "Nigeria",
                  flag: CountryFlag.fromCountryCode(
                    'NG',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "Egypt",
                  flag: CountryFlag.fromCountryCode(
                    'EG',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "US",
                  flag: CountryFlag.fromCountryCode(
                    'US',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                )),
                CountryWidget(
                    country: Country(
                  title: "Poland",
                  flag: CountryFlag.fromCountryCode(
                    'PL',
                    height: 48,
                    width: 62,
                    borderRadius: 8,
                  ),
                ))
              ],
            ),
          ),
          Expanded(flex: 4, child: Text("hell"))
        ],
      ),
    );
  }
}
