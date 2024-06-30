import 'package:flutter/material.dart';
import 'package:my_app/components/my_receipt.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:my_app/services/auth/login_or_register.dart';
import 'package:my_app/services/database/firestore.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;
import 'package:my_app/pages/home_page.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  //get access to db
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();
    //if we get to this page, submit order to firestore db
    String receipt = context.read<MyAppFactory.Factory>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        //clear cart 
        context.read<MyAppFactory.Factory>().clearCart();
        return true; //allow the pop action  
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: _buildBottomNavBar(context),
        body: const Column(
          children: [
            //here to make sure the content not overflowing the device
            Expanded(
              child: SingleChildScrollView(
                child: MyReceipt(),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Custom Bottom Nav Bar - Message / Call delivery driver
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              //Profile pic of driver
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(width: 10),
              //chauffeur detail
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DHL Express",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  Text(
                    "Chauffeur",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  //message button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  //call button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.call),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Home and Logout buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                  context.read<MyAppFactory.Factory>().clearCart();
              
                },
                child: const Text("HOME"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), backgroundColor: const Color.fromARGB(255, 253, 245, 232),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final _authService = AuthService();
                  _authService.signOut();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginOrRegister()),
                  );
                  context.read<MyAppFactory.Factory>().clearCart();
                 
                },
                child: const Text("LOGOUT"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), backgroundColor:  const Color.fromARGB(255, 253, 245, 232)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
