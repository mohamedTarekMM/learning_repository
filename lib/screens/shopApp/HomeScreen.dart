import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_cubit.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_state.dart';
import 'package:wether_app/models/shopModels/productModel.dart';
import 'package:wether_app/screens/shopApp/updateScreen/updateScreen.dart';
import 'package:wether_app/shared/components.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
        var productList = ShopCubit.get(context).productList;
        return Scaffold(
          backgroundColor: Colors.white,
            body: ConditionalBuilder(
              condition: productList.isNotEmpty,
              builder: (context)=>Padding(
                padding: const EdgeInsets.only(top: 60.0,right: 16,left: 16),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: productList.length,
                    clipBehavior: Clip.none,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 50,
                    ), itemBuilder: (context,index)=>gridItem(context,productList[index])),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            )
        );
      },
    );
  }
  Widget gridItem(context,ProductModel productModel)=>GestureDetector(
    onTap: (){
    //  defaultNavigatorTo(context,widget: UpdateScreen(productId: productModel.id!));
      Navigator.pushNamed(context, UpdateScreen.id,arguments: productModel);
    },
    child: Stack(
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
                          onPressed: () {
                            ShopCubit.get(context).getFavorite();
                          },
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
    ),
  );
}
