import 'package:bootcamp_hw_capstone/core/bottom_navigation_bar.dart';
import 'package:bootcamp_hw_capstone/core/constants/constants.dart';
import 'package:bootcamp_hw_capstone/data/models/food_cart_model.dart';
import 'package:bootcamp_hw_capstone/data/models/ordered_cart_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/cart_dialog_bloc.dart';

import 'package:bootcamp_hw_capstone/ui/bloc/cart_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartPageCubit>().getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int a = 0;
    return Scaffold(
        bottomNavigationBar: const CustomBottomBar(),
        body: BlocBuilder<CartPageCubit, CartPageState>(
          builder: (context, state) {
            if (state is CartPageLoadedState) {
              List<SepetYemekler> snapshot = state.data;
              var orderedCartList =
                  context.read<CartPageCubit>().ordereCartModelList(snapshot);

              for (var yemek in orderedCartList) {
                a += (yemek.yemekSiparisAdet * int.parse(yemek.yemekFiyat));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          "Sepetim",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Genel Toplam : $a",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderedCartList.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 2),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Image.network(
                                "${AppConstants.yemekUrl}${orderedCartList[index].yemekResimAdi}",
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderedCartList[index].yemekAdi,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                          "Fiyat: ${orderedCartList[index].yemekFiyat}"),
                                      Text(
                                          "Adet: ${orderedCartList[index].yemekSiparisAdet}"),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CartDialogBloc>()
                                            .setItemCount(orderedCartList[index]
                                                .yemekSiparisAdet);
                                        showUpdateItemDialog(
                                                context, orderedCartList, index)
                                            .then((value) => context
                                                .read<CartPageCubit>()
                                                .getCartItems());
                                      },
                                      icon: const Icon(Icons.delete_outline),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 12),
                                      child: Text(
                                          "Toplam : ${int.parse(orderedCartList[index].yemekFiyat) * orderedCartList[index].yemekSiparisAdet}"),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CartPageErrorState) {
              return const Center(
                child: Text("Sepette ürün bulunamadı,"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<dynamic> showUpdateItemDialog(
      BuildContext context, List<OrderedCartModel> orderedCartList, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${orderedCartList[index].yemekAdi} adetini güncelleyin :"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<CartDialogBloc>().itemCountDowngrader();
                },
                child: const Icon(Icons.remove)),
            const SizedBox(
              width: 28,
            ),
            BlocBuilder<CartDialogBloc, int>(
              builder: (context, itemCount) => Text(
                itemCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(
              width: 28,
            ),
            BlocBuilder<CartDialogBloc, int>(builder: (context, state) {
              return Visibility(
                visible: state < orderedCartList[index].yemekSiparisAdet,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<CartDialogBloc>().itemCountUpgrader(
                          orderedCartList[index].yemekSiparisAdet);
                    },
                    child: const Icon(Icons.add)),
              );
            }),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
            onPressed: () async {
              await FoodRepository().updateItemInCart(
                  orderedCartList[index].sepetYemekId,
                  (orderedCartList[index].yemekSiparisAdet -
                      context.read<CartDialogBloc>().itemCount));
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text(
              "Güncelle",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
