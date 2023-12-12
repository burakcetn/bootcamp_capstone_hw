import 'package:bootcamp_hw_capstone/core/bottom_navigation_bar.dart';
import 'package:bootcamp_hw_capstone/core/constants/constants.dart';
import 'package:bootcamp_hw_capstone/core/utils/custom_snackbar.dart';
import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';

import 'package:bootcamp_hw_capstone/ui/bloc/home_page_cubit.dart';
import 'package:bootcamp_hw_capstone/ui/view/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomePageCubit>().getFoodList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomBar(),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageDataLoadedState) {
            List<Yemekler> snapshot = state.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appbarWidgetbuilder(context),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Products",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                  ),
                ),
                Flexible(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    itemCount: snapshot.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.75,
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(yemek: snapshot[index]))),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Image.network(
                                    "${AppConstants.yemekUrl}${snapshot[index].yemekResimAdi}",
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  snapshot[index].yemekAdi,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "₺ ${snapshot[index].yemekFiyat}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontFamily: ""),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        bool isDone = await FoodRepository()
                                            .setItemToCart(snapshot[index]);
                                        if (isDone) {
                                          CustomSnackBar.showCustomSnackBar(
                                              title: "Başarılı",
                                              message:
                                                  "Sepete 1 adet ${snapshot[index].yemekAdi} eklediniz");
                                        } else {
                                          CustomSnackBar.showCustomErrorSnackBar(
                                              title: "Tekrar Deneyiniz!",
                                              message:
                                                  "Bir hatayla karşılaşıldı");
                                        }
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is HomePageErrorState) {
            return Center(
              child: Text("Bir sorunla Karşılaşıldı: ${state.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  SizedBox appbarWidgetbuilder(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 72),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Merhaba, Kullanıcı",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            color: Colors.black38,
                          ),
                          Text(
                            "Konum bilgisini Güncelleyin",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ]),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Icon(Icons.search),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Yemek Ara",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        context.read<HomePageCubit>().searchFood(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
