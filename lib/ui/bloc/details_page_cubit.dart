import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPageCubit extends Cubit<int> {
  DetailsPageCubit() : super(0);

  int itemCount = 0;

  void itemCountUpgrader() {
    itemCount++;
    emit(itemCount);
  }

  void resetItemCount() {
    itemCount = 0;
    emit(itemCount);
  }

  void itemCountDowngrader() {
    if (itemCount > 0) {
      itemCount--;
      emit(itemCount);
    } else {
      emit(itemCount);
    }
  }
}
