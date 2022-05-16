import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:app_pde/app/shared/widgets/page_section.dart';
import 'package:flutter/material.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(Constants.defaultBorderRadius),
      ),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            const CustomDrawerHeader(),
            PageSection(),
          ],
        ),
      ),
    );
  }
}
