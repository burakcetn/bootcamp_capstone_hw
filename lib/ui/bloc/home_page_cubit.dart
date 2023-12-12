import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';
import 'package:bootcamp_hw_capstone/data/repositories/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Durumları temsil eden sınıfları tanımlayalım
abstract class HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageErrorState extends HomePageState {
  final String error;

  HomePageErrorState(this.error);
}

class HomePageDataLoadedState extends HomePageState {
  final List<Yemekler> data;

  HomePageDataLoadedState(this.data);
}

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageLoadingState());

  Future<void> searchFood(String query) async {
    var list = await LocalRepository().searchFood(query);
    emit(HomePageDataLoadedState(list));
  }

  void getFoodList() async {
    try {
      emit(HomePageLoadingState());

      List<Yemekler> list = await FoodRepository().getFoodList();
      LocalRepository().setList(list);

      emit(HomePageDataLoadedState(list));
    } catch (e) {
      emit(HomePageErrorState('Bir hata oluştu: $e'));
    }
  }
}
