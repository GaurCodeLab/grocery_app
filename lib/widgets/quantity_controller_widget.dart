import 'package:flutter/material.dart';

class QuantityController extends StatelessWidget {

  const QuantityController(
      {Key? key, required this.fct, required this.icon, required this.color })
      : super(key: key);
  final Function fct;
  final IconData icon;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Flexible(

      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


