import 'package:country_flags/country_flags.dart';
import '../models/country.dart';

List countries = [
  Country(
    title: "Tunisia",
    flag: CountryFlag.fromCountryCode(
      'TN',
      height: 58,
      width: 72,
      borderRadius: 8,
    ),
  ),
  Country(
    title: "Libiya",
    flag: CountryFlag.fromCountryCode(
      'LY',
      height: 58,
      width: 72,
      borderRadius: 8,
    ),
  ),
  Country(
    title: "Algeria",
    flag: CountryFlag.fromCountryCode(
      'DZ',
      height: 58,
      width: 72,
      borderRadius: 8,
    ),
  ),
  Country(
    title: "Egypt",
    flag: CountryFlag.fromCountryCode(
      'EG',
      height: 58,
      width: 72,
      borderRadius: 8,
    ),
  ),
  Country(
    title: "Morroco",
    flag: CountryFlag.fromCountryCode(
      'MA',
      height: 58,
      width: 72,
      borderRadius: 8,
    ),
  ),
];
