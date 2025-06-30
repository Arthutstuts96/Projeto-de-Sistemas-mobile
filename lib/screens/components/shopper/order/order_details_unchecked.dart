import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/order_item.dart';

class OrderDetailsUnchecked extends StatefulWidget {
  const OrderDetailsUnchecked({super.key, required this.items});

  final List<OrderItem> items;

  @override
  State<OrderDetailsUnchecked> createState() => _OrderDetailsUncheckedState();
}

class _OrderDetailsUncheckedState extends State<OrderDetailsUnchecked> {
  late Map<int, bool> _checkedItems;

  @override
  void initState() {
    super.initState();

    _checkedItems = {for (var i = 0; i < widget.items.length; i++) i: false};
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Center(
        child: Text(
          'Não há itens neste pedido.',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    final int checkedCount = _checkedItems.values.where((v) => v).length;
    final double progress =
        widget.items.isEmpty ? 0 : checkedCount / widget.items.length;

    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFF8DC)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Itens a Separar",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$checkedCount / ${widget.items.length}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.brown.shade100,
              color: Colors.green,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const Divider(thickness: 1.5),
          Expanded(
            child: ListView.separated(
              itemCount: widget.items.length,
              separatorBuilder:
                  (_, __) => const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 184, 149, 136),
                    indent: 16,
                    endIndent: 16,
                  ),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final bool isChecked = _checkedItems[index] ?? false;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isChecked
                            ? Colors.green.shade50.withOpacity(0.7)
                            : Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(6, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor:
                          isChecked ? Colors.green : Colors.brown.shade100,
                      child:
                          isChecked
                              ? const Icon(Icons.check, color: Colors.white)
                              : Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                    title: Text(
                      'Produto ID: ${item.produtoId ?? "N/A"}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        decoration:
                            isChecked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Quantidade: ${item.quantidade}')],
                    ),
                    trailing: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _checkedItems[index] = value ?? false;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
