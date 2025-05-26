import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/cart_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';

// ignore: must_be_immutable
class ChangeQuantityButton extends StatefulWidget {
  const ChangeQuantityButton({super.key, required this.product});
  final Product product;

  @override
  State<ChangeQuantityButton> createState() => _ChangeQuantityButtonState();
}

class _ChangeQuantityButtonState extends State<ChangeQuantityButton> {
  void changeProductQuantity() async {
    final updatedProduct = widget.product.copyWith(
      quantityToBuy: widget.product.quantityToBuy,
    );
    await CartController().editItemFromCart(product: updatedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFD9D9D9),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCircleButton(
              icon: Icons.add,
              color: const Color(0xFFAEAEAE),
              onTap: () {
                setState(() {
                  widget.product.quantityToBuy++;
                  changeProductQuantity();
                });
              },
            ),
            const SizedBox(width: 8),
            Text("${widget.product.quantityToBuy}"),
            const SizedBox(width: 8),
            _buildCircleButton(
              icon: Icons.remove,
              color: const Color(0xFFAEAEAE),
              onTap: () {
                setState(() {
                  if (widget.product.quantityToBuy > 1) {
                    widget.product.quantityToBuy--;
                    changeProductQuantity();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
