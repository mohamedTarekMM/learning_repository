import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_state.dart';
import 'package:wether_app/models/shopModels/productModel.dart';
import 'package:wether_app/screens/shopApp/CategoriesScreen.dart';
import 'package:wether_app/screens/shopApp/FavoritesScreen.dart';
import 'package:wether_app/screens/shopApp/ProfileScreen.dart';
import 'package:wether_app/screens/shopApp/SearchScreen.dart';
import 'package:wether_app/shared/dio_helper.dart';
import '../../../screens/shopApp/HomeScreen.dart';
import '../../weather_layout/Home_Screen.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitShopAppState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
  ];
  List<Widget> screens = [
    ShopHomeScreen(),
    ShopCategoriesScreen(),
  ];

  void changeNav(int index) {
    currentIndex = index;
    emit(ChangeNavState());
  }
  List<dynamic> favorite = [];
  ProductModel? productModel;
  List<ProductModel> productList = [];

  getAllProduct() {
    DioHelper.getData(path: 'products').then((value) {
      List<dynamic> pro = value.data;
      pro.forEach((element) {
        productList.add(ProductModel.fromJson(element));
      });
      emit(GetAllProductSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllProductErrorState());
    });
  }

  updateProduct({
    required int id,
    String? title,
    dynamic price,
    String? description,
    String? category,
    String? image,
  }) async {
    emit(UpdateProductLoadingState());
    ProductModel model = ProductModel(
        id: id,
        title: title,
        image: image,
        category: category,
        description: description,
        price: price);
    await DioHelper.updateData(path: 'products/$id', data: model.toJson())
        .then((value) {
      print(value.data);
      productModel = ProductModel.fromJson(value.data);
      emit(UpdateProductSuccessfulState());
      getAllProduct();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProductErrorState());
    });
  }

  List<dynamic>? categories;

  getCategories() {
    DioHelper.getData(path: 'products/categories').then((value) {
      categories = value.data;
      print(value.data);
      emit(GetCategoriesSuccessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoriesErrorState());
    });
  }

List<ProductModel> categoriesDetails = [];
  getCategoriesDetails({required String catName}) {
    categoriesDetails = [];
    DioHelper.getData(path: 'products/category/$catName')
        .then((value) {
      List<dynamic> pro = value.data;
      pro.forEach((element) {
        categoriesDetails.add(ProductModel.fromJson(element));
      });
      print(categoriesDetails[0].id);
      emit(GetAllCategoriesDetSuccessfulState());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetAllCategoriesDetErrorState());
    });
  }

  getFavorite(){
    productModel!.id = !productModel!.id;
    //productModel!.inFavorite = !productModel.inFavorite;
    emit(GetLikedSuccessfulState());
  }
}
