import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_cubit.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_state.dart';

import '../../models/shopModels/productModel.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({Key? key}) : super(key: key);
  static String id = 'CategoriesDetails';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
       // var catName = ModalRoute.of(context)!.settings.arguments;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 60.0,right: 16,left: 16),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 60,
                ),
                itemBuilder: (context,index)=>gridItem(context,cubit.categoriesDetails[index]),
        itemCount: cubit.categoriesDetails.length,
            ),
          ),
        );
      },
    );
  }
  Widget gridItem(context,ProductModel productModel)=>Stack(
    clipBehavior: Clip.none,
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey[100] as Color,
            spreadRadius: 0,
            blurRadius: 200,
            offset: const Offset(0, 0),
          )
        ]),
        child: Card(
          elevation: 17,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.title!,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 15,color: Colors.grey[400],overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(r'$''${productModel.price}'),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.heart))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 120,
          child: Image.network(
            productModel.image!,
            width: 100,
            height: 100,
          )),
    ],
  );

}
