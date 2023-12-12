import 'package:flutter_bloc/flutter_bloc.dart';

class CartDialogBloc extends Cubit<int> {
  CartDialogBloc() : super(0);

  int itemCount = 0;

  void setItemCount(int a) {
    itemCount = a;
    emit(a);
  }

  void itemCountUpgrader(int a) {
    if (itemCount < a) {
      itemCount++;
      emit(itemCount);
    } else {
      emit(itemCount);
    }
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
