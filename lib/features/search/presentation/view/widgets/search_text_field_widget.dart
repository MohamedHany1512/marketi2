import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/features/home/presentation/view_model/products_cubit.dart';
import 'package:marketi/features/home/presentation/view_model/products_states.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.search,
              arguments: {
                'categories': state.categories,
                'brands': state.brands,
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Text(
                  'What are you looking for?',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}