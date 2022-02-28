import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_cubit.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_state.dart';
import 'package:wether_app/screens/shopApp/cat_deatiels.dart';
import 'package:wether_app/shared/components.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){
        if(state is GetAllCategoriesDetSuccessfulState){
          defaultNavigatorTo(context,widget: CategoriesDetails());
        }
      },
      builder: (context,state){
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemBuilder: (context,index)=>catItem(context,index),
              separatorBuilder: (context,index)=>const SizedBox(height: 20,),
              itemCount: ShopCubit.get(context).categories!.length
          ),
        );
      },
    );
  }
  Widget catItem(context,index)=>Container(
    padding: EdgeInsetsDirectional.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(10),
      color: Colors.grey[200],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${ShopCubit.get(context).categories![index]}',style: Theme.of(context).textTheme.headline6,),
        IconButton(onPressed: (){
          ShopCubit.get(context).getCategoriesDetails(catName: ShopCubit.get(context).categories![index]);
        }, icon: const Icon(FontAwesomeIcons.solidArrowAltCircleRight))
      ],
    ),
  );
}
