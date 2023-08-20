import 'package:flutter/material.dart';
import 'package:food/models/restaurant.dart';

class ProductDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const ProductDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final rating = restaurant.rating;
    final bool filterStar = (restaurant.rating % 1) != 0;

    return Scaffold(
      backgroundColor: Colors.red[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: const Icon(Icons.arrow_back_ios),
      //   actions: const [Icon(Icons.favorite), SizedBox(width: 20)],
      // ),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Hero(
              tag: restaurant.imageUrl,
              child: Image.asset(
                restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                    ),
                    const Spacer(),
                    const Icon(Icons.favorite, color: Colors.white),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            )
          ]),
          const SizedBox(height: 20),
          _Address(
            restaurant: restaurant,
            rating: rating,
            filterStar: filterStar,
          ),
          const SizedBox(height: 20),
          const _Contact(),
          const SizedBox(height: 10),
          const Center(
              child: Text(
            "Menu",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                ),
                itemCount: restaurant.menu.length,
                itemBuilder: (context, index) {
                  final menu = restaurant.menu[index];
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          menu.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Text(
                              menu.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${menu.price}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact();

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      FilledButton(
        onPressed: () {},
        child: const Text(
          "Review",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      FilledButton(
        onPressed: () {},
        child: const Text(
          "Review",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}

class _Address extends StatelessWidget {
  const _Address({
    required this.restaurant,
    required this.rating,
    required this.filterStar,
  });

  final Restaurant restaurant;
  final double rating;
  final bool filterStar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(
            restaurant.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const Spacer(),
          const Text("0.2 milles away")
        ]),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ]),
    );
  }
}
