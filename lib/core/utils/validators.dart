import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';

class Validators {
  static const List<String> validCountries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo, Democratic Republic of the',
    'Congo, Republic of the',
    'Costa Rica',
    'Cote d\'Ivoire',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, North',
    'Korea, South',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];
  static String? displayNamevalidator(
      String? displayName, BuildContext context) {
    if (displayName == null || displayName.isEmpty) {
      return S.of(context).Displaynamecannotbeempty;
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return S.of(context).Displaynamemustbebetween3and20characters;
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return S.of(context).Pleaseenteranemail;
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return S.of(context).Pleaseenteravalidemail;
    }
    return null;
  }

  static String? passwordValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return S.of(context).Pleaseenterapassword;
    }
    if (value.length < 6) {
      return S.of(context).Passwordmustbeatleast6characterslong;
    }
    return null;
  }

  static String? contactNumberValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return S.of(context).PleaseentercontactNumber;
    }
    if (value.length < 11) {
      return S.of(context).contactNumbermustbe11characterslong;
    }
    return null;
  }

  static String? displayAddressvalidator(
      String? displayAddress, BuildContext context) {
    if (displayAddress == null || displayAddress.isEmpty) {
      return S.of(context).DisplayAddresscannotbeempty;
    }
    if (displayAddress.length < 50 || displayAddress.length > 255) {
      return S.of(context).DisplayAddressmustbebetween50and255characters;
    }
    return null;
  }

  static String? genderValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).Gendercannotbeempty;
    }
    if (value != 'Female' ||
        value != 'Male' ||
        value != 'ذكر' ||
        value != 'أنثي' ||
        value != 'male' ||
        value != 'female') {
      return S.of(context).Gendercanbefemaleormaleonly;
    }
    return null;
  }

  static String? countryNameValidator(
      String? countryName, BuildContext context) {
    if (countryName == null || countryName.isEmpty) {
      return S.of(context).Countrynamecannotbeempty;
    }
    if (!validCountries.contains(countryName)) {
      return S.of(context).Pleaseenteravalidcountryname;
    }
    return null;
  }
}
