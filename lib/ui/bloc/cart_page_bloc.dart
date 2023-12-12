import 'package:bootcamp_hw_capstone/data/models/food_cart_model.dart';
import 'package:bootcamp_hw_capstone/data/models/ordered_cart_model.dart';

import 'package:bootcamp_hw_capstone/data/repositories/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CartPageState {}

class CartPageLoadingState extends CartPageState {}

class CartPageErrorState extends CartPageState {
  final String error;

  CartPageErrorState(this.error);
}

class CartPageLoadedState extends CartPageState {
  final List<SepetYemekler> data;

  CartPageLoadedState(this.data);
}

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(CartPageLoadingState());

  void getCartItems() async {
    try {
      emit(CartPageLoadingState());

      List<SepetYemekler> list =
          await FoodRepository().getCartItems("burak_cetin");

      //  print(jsonEncode(orderedList));
      emit(CartPageLoadedState(list));
    } catch (e) {
      emit(CartPageErrorState('Bir hata oluştu: $e'));
    }
  }

  List<OrderedCartModel> ordereCartModelList(
      List<SepetYemekler> sepetYemeklerListesi) {
    Map<String, OrderedCartModel> gruplanmisUrunler = {};

    for (var sepetYemek in sepetYemeklerListesi) {
      var yemekAdi = sepetYemek.yemekAdi;
      var yemekSiparisAdet = int.parse(sepetYemek.yemekSiparisAdet);
      List<int> ids = [];

      if (gruplanmisUrunler.containsKey(yemekAdi)) {
        // Eğer ürün zaten gruplanmışsa, yemek_siparis_adet'i topla.
        gruplanmisUrunler[yemekAdi]!.yemekSiparisAdet += yemekSiparisAdet;
        gruplanmisUrunler[yemekAdi]!
            .sepetYemekId
            .add(int.parse(sepetYemek.sepetYemekId));
      } else {
        // Eğer ürün henüz gruplanmamışsa, yeni bir OrderedCartModel oluştur.

        ids.add(int.parse(sepetYemek.sepetYemekId));
        var orderedCartModel = OrderedCartModel(
            kullaniciAdi: sepetYemek.kullaniciAdi,
            sepetYemekId: ids,
            yemekAdi: sepetYemek.yemekAdi,
            yemekResimAdi: sepetYemek.yemekResimAdi,
            yemekFiyat: sepetYemek.yemekFiyat,
            yemekSiparisAdet: int.parse(sepetYemek.yemekSiparisAdet));
        orderedCartModel.yemekSiparisAdet = yemekSiparisAdet;
        gruplanmisUrunler[yemekAdi] = orderedCartModel;
      }
    }

    // Gruplanmış ürünleri bir liste halinde döndürelim.
    return gruplanmisUrunler.values.toList();
  }
}
