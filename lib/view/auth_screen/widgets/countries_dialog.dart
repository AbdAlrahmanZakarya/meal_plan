import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';

class CountriesDialog extends StatefulWidget {
  final List<Map<String, String>> countries;

  const CountriesDialog({super.key, required this.countries});

  @override
  State<CountriesDialog> createState() => _CountriesDialogState();
}

class _CountriesDialogState extends State<CountriesDialog> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> searchedCountry = [];

  onchange(String val) {
    if (val.isNotEmpty) {
      setState(() {
        searchedCountry.clear();
        searchedCountry.addAll(
          widget.countries
              .where((element) =>
                  element['name']!.toLowerCase().contains(val.toLowerCase()))
              .toList(),
        );
      });
    } else {
      searchedCountry.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Center(child: Text('Choose Region')),
        content: SizedBox(
          width: 100.w > 500 ? 470 : double.maxFinite,
          height: 60.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  onChanged: onchange,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    hintText: 'Search Country Name...',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.gray),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: AppColors.gray),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: searchController.text.isEmpty
                      ? widget.countries.length
                      : searchedCountry.length,
                  itemBuilder: (ctx, index) {
                    return CountryListItem(
                      country: searchController.text.isEmpty
                          ? widget.countries[index]
                          : searchedCountry[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryListItem extends StatelessWidget {
  final Map<String, String> country;

  const CountryListItem({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(country);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(country['flag']!),
            Expanded(
              child: Text(
                '  ${country['dial_code']!}  ${country['name']!}',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
