import 'package:flutter/material.dart';
import 'package:flutter_grocery/common/models/product_model.dart';
import 'package:flutter_grocery/helper/price_converter_helper.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constraints.dart';
import 'package:flutter_grocery/common/providers/product_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/common/widgets/custom_directionality_widget.dart';
import 'package:provider/provider.dart';

class ProductTitleWidget extends StatelessWidget {
  final Product? product;
  final int? stock;
  final int? cartIndex;
  final double price;
  final double taxedPrice;
  final double discountedPrice;
  const ProductTitleWidget(
      {Key? key,
      required this.product,
      required this.stock,
      required this.taxedPrice,
      required this.cartIndex,
      required this.price,
      required this.discountedPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Padding(
          padding: EdgeInsets.only(
              right: Dimensions.paddingSizeSmall,
              top: Dimensions.paddingSizeSmall,
              left: ResponsiveHelper.isDesktop(context)
                  ? 0
                  : Dimensions.paddingSizeSmall),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              product?.name ?? '',
              style: poppinsSemiBold.copyWith(
                  fontSize: ResponsiveHelper.isDesktop(context)
                      ? Dimensions.fontSizeOverLarge
                      : Dimensions.fontSizeLarge,
                  color: Theme.of(context).textTheme.bodyLarge?.color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            Row(children: [
              product?.rating != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall,
                          vertical: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorResources.ratingColor.withOpacity(0.1),
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.star_rounded,
                                color: ColorResources.ratingColor,
                                size: Dimensions.paddingSizeDefault),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Text(
                              product!.rating!.isNotEmpty
                                  ? double.parse(product!.rating![0].average!)
                                      .toStringAsFixed(1)
                                  : '0.0',
                              style: poppinsMedium.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withOpacity(0.6),
                                  fontSize: Dimensions.fontSizeSmall),
                            ),
                          ]),
                    )
                  : const SizedBox(),
              SizedBox(
                  width: product!.rating != null
                      ? Dimensions.paddingSizeSmall
                      : 0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusSizeLarge),
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                  color: /*product!.totalStock! > 0
                      ?  Theme.of(context).primaryColor
                      :*/
                      Theme.of(context).primaryColor.withOpacity(0.05),
                ),
                child: Text(
                  getTranslated(
                      product!.totalStock! > 0 ? 'in_stock' : 'stock_out',
                      context),
                  style: poppinsSemiBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeSmall),
                ),
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            // Text(
            //   '${product!.capacity} ${product!.unit}',
            //   style: poppinsMedium.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeDefault),
            // ),
            // const SizedBox(height: Dimensions.paddingSizeDefault),

            //Product Price
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDirectionalityWidget(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'MRP:  ',
                            style: poppinsRegular.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: Dimensions.fontSizeExtraLarge,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 75,
                        child: Text(
                          PriceConverterHelper.convertPrice(context, price),
                          // '${endingPrice != null ? ' - ${PriceConverterHelper.convertPrice(context, endingPrice)}' : ''}',
                          style: poppinsRegular.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: Dimensions.fontSizeExtraLarge,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDirectionalityWidget(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 25,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Deal Price:  ',
                          style: poppinsRegular.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${PriceConverterHelper.convertPrice(
                                    context,
                                    discountedPrice,
                                  )} excl. GST',
                                  style: poppinsBold.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions.fontSizeExtraLarge
                                            : Dimensions.fontSizeExtraLarge,
                                  ),
                                )
                              ],
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                                text: PriceConverterHelper.convertPrice(
                                  context,
                                  taxedPrice,
                                ),
                                style: poppinsBold.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions.fontSizeExtraLarge
                                            : Dimensions.fontSizeExtraLarge),
                                children: [
                                  
                                  TextSpan(
                                      text: ' incl. GST',
                                      style: poppinsBold.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: ResponsiveHelper.isDesktop(
                                                  context)
                                              ? Dimensions.fontSizeExtraLarge
                                              : Dimensions.fontSizeExtraLarge))
                                ]),
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                )),
                CustomDirectionalityWidget(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'You Save:  ',
                            style: poppinsRegular.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: Dimensions.fontSizeExtraLarge,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 75,
                        child: Text(
                          PriceConverterHelper.convertPrice(
                            context,
                            price - discountedPrice,
                          ),
                          style: poppinsBold.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: ResponsiveHelper.isDesktop(context)
                                  ? Dimensions.fontSizeExtraLarge
                                  : Dimensions.fontSizeExtraLarge),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        );
      },
    );
  }
}
