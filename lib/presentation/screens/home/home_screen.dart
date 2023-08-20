import 'package:flutter/material.dart';
import 'package:food/data/data.dart';

import 'package:food/config/constants/size_config.dart';
import 'package:food/presentation/screens/screens.dart';
import 'package:food/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        leading: const Icon(Icons.person_2),
        title: const Text("Food Delivery Ui"),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
              Positioned(
                top: 0,
                right: -5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(fontSize: 13)),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 20)
        ],
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFormField(),
          ),
          SizedBox(height: 30),
          _Titile(text: "Recent Order"),
          _OrderSection(),
          _Titile(text: "Nearby Restaurants"),
          SizedBox(height: 30),
          _RestaurantsSection(),
        ]),
      ),
    );
  }
}

class _RestaurantsSection extends StatelessWidget {
  const _RestaurantsSection();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          final rating = restaurant.rating;
          final bool filterStar = (restaurant.rating % 1) != 0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(restaurant: restaurant),
                  ),
                );
              },
              child: Row(children: [
                Hero(
                  tag: restaurant.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      restaurant.imageUrl,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(children: [
                        ...List.generate(5, (index) {
                          if (index < rating.floor()) {
                            return const Icon(
                              Icons.star,
                              color: Colors.orange,
                            );
                          }
                          if (filterStar && (index == rating.floor())) {
                            return const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            );
                          } else {
                            return const Icon(
                              Icons.star_border,
                              color: Colors.orange,
                            );
                          }
                        }),
                      ]),
                      const SizedBox(height: 5),
                      Text(
                        restaurant.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}

class _OrderSection extends StatelessWidget {
  const _OrderSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.horizontal,
          itemCount: currentUser.orders.length,
          itemBuilder: (context, index) {
            final order = currentUser.orders[index];

            return Padding(
              padding: index != currentUser.orders.length - 1
                  ? const EdgeInsets.only(right: 20)
                  : const EdgeInsets.only(right: 0),
              child: Container(
                width: SizeConfig.screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(1, 3),
                      color: Colors.black45,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          order.food.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order.food.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            order.restaurant.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            order.date,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Material(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(99),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(99),
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class _Titile extends StatelessWidget {
  final String text;
  const _Titile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
