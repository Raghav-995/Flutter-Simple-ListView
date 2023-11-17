import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class ProductCard extends StatelessWidget {
final Product product;

ProductCard({required this.product});

@override
Widget build(BuildContext context) {
	return Card(
	child: Padding(
		padding: const EdgeInsets.all(8.0),
		child: Column( // this is the coloumn
		children: [
			AspectRatio(
			aspectRatio: 16/9, // this is the ratio
			child: CachedNetworkImage( // this is to fetch the image
				imageUrl: product.image,
				fit: BoxFit.cover,
			),
			),
			ListTile(
			title: Text(product.title,style:TextStyle(fontFamily: 'Poppins',package:'Poppins-BlackItalic.ttf')),
			subtitle: Text('${product.price} \$',style:TextStyle(fontFamily: 'Poppins',package:'Poppins-Medium.ttf')), // this is fetch the price from the api
			trailing: Row(
				mainAxisSize: MainAxisSize.min,
				children: [
				Icon(Icons.star, color: Colors.orange),// this will give the rating
				Text('${product.rating}',style:TextStyle(fontFamily: 'Poppins',package:'Poppins-ExtraLight.ttf')),
				],
			),
			),
		],
		),
	),
	);
}
}
