
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_state.dart';
import 'cubit/shop_cubit.dart';

class ShopAppLayoutsScreen extends StatelessWidget {
  static String id = 'HomeLayoutsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener:(context,state){} ,
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('New Trend',style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.cartPlus,color: Colors.black,))
            ],
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (index){
              cubit.changeNav(index);
            },
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
