import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    FoodRepository().getFoodList();
    return Scaffold(
      body: BlocBuilder<HomePageCubit, List<Yemekler>>(
        builder: (context, snapshot) {
          if (snapshot.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appbarWidgetbuilder(context),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Products",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                  ),
                ),
                Flexible(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: snapshot.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemBuilder: (context, index) => Container(
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
                      child: Center(
                        child: Text(snapshot[index].yemekAdi),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Bir sorunla Karşılaşıldı"),
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
                  CircleAvatar(
                    radius: 32,
                  ),
                  SizedBox(
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
                          Icon(
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
              margin: EdgeInsets.symmetric(horizontal: 24),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Icon(Icons.search),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Yemek Ara",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
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
