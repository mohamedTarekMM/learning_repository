import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/layout/shopLayouts/Shop_Layout.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_cubit.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_state.dart';
import 'package:wether_app/models/shopModels/productModel.dart';
import 'package:wether_app/shared/components.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({Key? key}) : super(key: key);
  var namePr = TextEditingController();
  var descriptionPr = TextEditingController();
  var price = TextEditingController();
  var image = TextEditingController();
  static String id = 'updateProduct';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is UpdateProductSuccessfulState){
          defaultNavigateAndKill(context, ShopAppLayoutsScreen());
          defaultKeyboardDismissed(context: context);
        }
      },
      builder: (context, state) {
        ProductModel product = ModalRoute.of(context)!.settings.arguments as ProductModel;
        return GestureDetector(
          onTap: () {
            defaultKeyboardDismissed(context: context);
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: Text(
                'Update Product',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              // backgroundColor: Colors.white,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      defaultTextFormWithHintText(
                          controller: namePr,
                          keyboardType: TextInputType.text,
                          hintText: 'Product Name',
                          outlineInputBorder: OutlineInputBorder()),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormWithHintText(
                          controller: descriptionPr,
                          keyboardType: TextInputType.text,
                          hintText: 'description',
                          outlineInputBorder: OutlineInputBorder()),
                      const SizedBox(
                        height: 10,
                      ),
                     /* defaultTextFormWithHintText(
                          controller: price,
                          keyboardType: TextInputType.number,
                          hintText: 'price',
                          outlineInputBorder: OutlineInputBorder()),*/
                      const SizedBox(
                        height: 10,
                      ),
                    /*  defaultTextFormWithHintText(
                          controller: image,
                          keyboardType: TextInputType.text,
                          hintText: 'Image',
                          outlineInputBorder: OutlineInputBorder()),*/
                      const SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                        condition:state is! UpdateProductLoadingState,
                        builder: (context)=>defaultMaterialTextButton(
                            onPressed: () {
                              //print(product.id);
                              ShopCubit.get(context).updateProduct(
                                  id: product.id!,
                                  title: namePr.text ,
                                  description: descriptionPr.text,
                                  price: product.price,
                                  category: product.category,
                                  image: product.image
                              );
                              defaultKeyboardDismissed(context: context);
                            },
                            label: 'update',
                            isUpperCase: true,
                            radius: 10,
                            background: Theme.of(context).primaryColor),
                        fallback: (context)=>const Center(child: CircularProgressIndicator()),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
