import 'package:covid19/features/home/data/categories.dart';
import 'package:covid19/features/home/data/preventive_measures.dart';
import 'package:covid19/features/home/presentation/widgets/home_category.dart';
import 'package:covid19/features/home/presentation/widgets/section_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.44,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
        ),
        padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryCard(
          categories[index],
          onPress: () => {
             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SectionView(data[index])),
                        )            
                 
        }),
      ),
    );
  }
}
