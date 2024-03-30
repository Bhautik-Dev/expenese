import 'package:expense/controller/parties_controller.dart';
import 'package:expense/controller/product_controller.dart';
import 'package:expense/controller/purchese_controller.dart';
import 'package:expense/controller/sale_controller.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'category_controller.dart';
import 'expense_controller.dart';

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
  }

}