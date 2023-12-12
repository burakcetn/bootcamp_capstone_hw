import 'package:bootcamp_hw_capstone/core/constants/constants.dart';
import 'package:bootcamp_hw_capstone/core/utils/custom_snackbar.dart';
import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/details_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.yemek, super.key});
  final Yemekler yemek;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          yemek.yemekAdi,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child:
                  Image.network(AppConstants.yemekUrl + yemek.yemekResimAdi)),
          Text(
            "₺ ${yemek.yemekFiyat}",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontFamily: ""),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<DetailsPageCubit>().itemCountDowngrader();
                  },
                  child: const Icon(Icons.remove)),
              const SizedBox(
                width: 28,
              ),
              BlocBuilder<DetailsPageCubit, int>(
                builder: (context, itemCount) => Text(
                  itemCount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                width: 28,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<DetailsPageCubit>().itemCountUpgrader();
                  },
                  child: const Icon(Icons.add)),
            ],
          ),
          BlocBuilder<DetailsPageCubit, int>(
            builder: (context, itemCount) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: 180,
                    padding: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(14)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tutar:   ${itemCount * int.parse(yemek.yemekFiyat)}",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 32),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        int count = 0;
                        for (int x = 0;
                            // ignore: use_build_context_synchronously
                            x < context.read<DetailsPageCubit>().itemCount;
                            x++) {
                          await FoodRepository().setItemToCart(yemek);
                          count++;
                        }
                        CustomSnackBar.showCustomSnackBar(
                            title: yemek.yemekAdi,
                            message: "$count adet başarıyla eklendi");
                        // ignore: use_build_context_synchronously
                        context.read<DetailsPageCubit>().resetItemCount();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)))),
                      child: const Text("Sepete Ekle"),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
