import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(AppEndpoints.testimage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
