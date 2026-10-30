import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/function/custom_snack_bar.dart';

class CustomBookDetailsAppBar extends StatelessWidget {
  const CustomBookDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        IconButton(
          onPressed: () {
            customSnackBar(context, 'Shopping cart is not available in this version.');
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
          ),
        )
      ],
    );
  }
}
