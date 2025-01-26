import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/categories/productbycategorie_usecase.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_event.dart';
import 'package:http/http.dart' as http;
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/hot_deals.dart';
import '../../../../core/themes/app-color.dart';
import '../../../../core/themes/app_font.dart';
import '../../data/data_sources/remote_data_souces/productbycategorie_remote_datasources.dart';
import '../../data/repositories/productbycategorie_impl.dart';
import '../Bloc/productbycategorie/productbycategorie_state.dart';

class ProductByCategorie extends StatefulWidget {
  final String categoryname;
  final String categoryslug;

  const ProductByCategorie(
    this.categoryslug,
    this.categoryname, {
    super.key,
  });

  @override
  State<ProductByCategorie> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductByCategorie> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Gradient background
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              AppColor.Grey,
              Color(0xFF007AFF),
              AppColor.white,
            ],
          ),
        ),
      ),
      // Scaffold with transparent AppBar
      BlocProvider(
        create: (context) => ProductByCategoryBloc(
          getProductsByCategory: GetProductsByCategory(
            repository: ProductByCategoryRepositoryImpl(
              remoteDataSource: ProductbycategorieRemoteDatasources(
                client: http.Client(),
              ),
            ),
          ),
        )..add(FetchProductsByCategory(widget.categoryslug)),
        child: Scaffold(
          backgroundColor: Colors.transparent, // Make scaffold transparent
          appBar: AppBar(
            backgroundColor: Colors.transparent, // Fully transparent
            elevation: 0, // Remove shadow
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(
                  widget.categoryname,
                  style: AppFont.widgetTitle(
                      color: AppColor.principle, fontSize: 20),
                ),
              ),
            ),
          ),
          body: BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
            builder: (context, state) {
              if (state is ProductByCategoryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductByCategoryLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                rating: product.rating,
                                description: product.description,
                                title: product.title,
                                price: product.price,
                                thumbnail: product.thumbnail,
                              ),
                            ),
                          );
                        },
                        child: HotDeals(
                          title: product.title,
                          price: product.price,
                          thumbnail: product.thumbnail,
                          icon: Icons.favorite_border_outlined,
                        ),
                      );
                    },
                  ),
                );
              } else if (state is ProductByCategoryError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('Select a category to view products'));
            },
          ),
        ),
      )
    ]);
  }
}
