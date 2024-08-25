import 'package:ecommerceapp/models/category.dart';
import 'package:flutter/cupertino.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(categories[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                categories[index].title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: 20), // Horizontal space between items
      ),
    );
  }
}
