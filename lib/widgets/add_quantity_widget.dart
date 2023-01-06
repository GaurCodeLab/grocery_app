import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/quantity_controller_widget.dart';

class AddToCartQuantity extends StatefulWidget {
  TextEditingController quantityTextController = TextEditingController();

  AddToCartQuantity({
    Key? key,
    required this.quantityTextController,
  }) : super(key: key);

  @override
  State<AddToCartQuantity> createState() => _AddToCartQuantityState();
}

class _AddToCartQuantityState extends State<AddToCartQuantity> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    @override
    void initState() {
      widget.quantityTextController.text = '1';
      super.initState();
    }

    @override
    void dispose() {
      widget.quantityTextController.dispose();
      super.dispose();
    }

    return SizedBox(
      width: size.width * 0.5,
      child: Row(
        children: [
          QuantityController(
            fct: () {},
            icon: CupertinoIcons.minus,
            color: Colors.red,
          ),
          Flexible(
            flex: 1,
            child: TextField(
              controller: widget.quantityTextController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              onChanged: (v) {
                setState(() {
                  if (v.isEmpty) {
                    widget.quantityTextController.text = '1';
                  } else {
                    return;
                  }
                });
              },
            ),
          ),
          QuantityController(
              fct: () {}, icon: CupertinoIcons.plus, color: Colors.green),
        ],
      ),
    );
  }
}
