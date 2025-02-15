import 'package:my_ecom_app/features/product/domain/entities/cart_entities.dart';

import '../../data/repositories/CartRepositoryImpl.dart';

abstract class AddToCartUseCase {
  Future<void> call(String userId, int productId, String title, double price,
      String thumbnail, int quantity);
}

class AddToCartUseCaseImpl implements AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCaseImpl(this.repository);

  @override
  Future<void> call(String userId, int productId, String title, double price,
      String thumbnail, int quantity) {
    return repository.addToCart(
        userId, productId, title, price, thumbnail, quantity);
  }
}

abstract class UpdateCartUseCase {
  Future<void> call(String userId, int productId, int quantity);
}

class UpdateCartUseCaseImpl implements UpdateCartUseCase {
  final CartRepository repository;

  UpdateCartUseCaseImpl({required this.repository});

  @override
  Future<void> call(String userId, int productId, int quantity) {
    return repository.updateCart(userId, productId, quantity);
  }
}

abstract class RemoveFromCartUseCase {
  Future<void> call(String userId, int productId);
}

class RemoveFromCartUseCaseImpl implements RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCaseImpl(this.repository);

  @override
  Future<void> call(String userId, int productId) {
    return repository.removeFromCart(userId, productId);
  }
}

abstract class GetCartItemsUseCase {
  Future<List<CartEntities>> call(String userId);
}

class GetCartItemsUseCaseImpl implements GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCaseImpl({required this.repository});

  @override
  Future<List<CartEntities>> call(String userId) {
    return repository.getCartItems(userId);
  }
}
