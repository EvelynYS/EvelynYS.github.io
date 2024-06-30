import 'package:flutter/material.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({super.key});

  final textController = TextEditingController();
  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your location'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: "Enter address"),
        ),
        actions: [
          //cancel btn
          MaterialButton(
            onPressed: () { 
            Navigator.pop(context);
            textController.clear();
            },
            child: const Text('Cancel'),
          ),
          //save btn
          MaterialButton(
            onPressed: () { 
            String newAddress = textController.text;
            context.read<MyAppFactory.Factory>().updateDeliveryAddress(newAddress);
            Navigator.pop(context);
            textController.clear();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver Now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                //address
               Consumer<MyAppFactory.Factory>(builder:(context, factory, child)=> Text(factory.deliveryAddress, style: TextStyle(color:Theme.of(context).colorScheme.inversePrimary, fontWeight:FontWeight.bold,
               ),
               ),
               ),
                //dropdown menu
                Icon(Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.inversePrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
