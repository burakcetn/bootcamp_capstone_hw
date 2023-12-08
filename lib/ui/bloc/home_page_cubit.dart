import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<List<Yemekler>> {
  HomePageCubit() : super(<Yemekler>[]);

  getFoodList() async {
    List<Yemekler> list = [];
    list = await FoodRepository().getFoodList();
    emit(list);
  }
}
