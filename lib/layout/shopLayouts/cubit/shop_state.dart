abstract class ShopState {}

class InitShopAppState extends ShopState{}
class ChangeNavState extends ShopState{}


class GetAllProductSuccessfulState extends ShopState{}
class GetAllProductErrorState extends ShopState{}


class GetAllCategoriesDetSuccessfulState extends ShopState{}
class GetAllCategoriesDetErrorState extends ShopState{}

class PostProductSuccessfulState extends ShopState{}
class PostProductErrorState extends ShopState{}


class UpdateProductLoadingState extends ShopState{}
class UpdateProductSuccessfulState extends ShopState{}
class UpdateProductErrorState extends ShopState{}


class GetCategoriesSuccessfulState extends ShopState{}
class GetCategoriesErrorState extends ShopState{}


class GetLikedSuccessfulState extends ShopState{}
class GetLikedErrorState extends ShopState{}