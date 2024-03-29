import 'package:expenese/controller/auth_controller.dart';
import 'package:expenese/controller/category_controller.dart';
import 'package:expenese/controller/expense_controller.dart';
import 'package:expenese/controller/parties_controller.dart';
import 'package:expenese/controller/product_controller.dart';
import 'package:expenese/controller/purchese_controller.dart';
import 'package:expenese/controller/sale_controller.dart';
import 'package:expenese/controller/user_controller.dart';
import 'package:get/get.dart';

class BindingController implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ExpenseController>(() => ExpenseController(),fenix: true);
    Get.lazyPut<SaleController>(() => SaleController(),fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(),fenix: true);
    Get.lazyPut<PartiesController>(() => PartiesController(),fenix: true);
    Get.lazyPut<CategoryController>(() => CategoryController(),fenix: true);
    Get.lazyPut<PurchaseController>(() => PurchaseController(),fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(),fenix: true);
    Get.lazyPut<UserController>(() => UserController(),fenix: true);
  }

}