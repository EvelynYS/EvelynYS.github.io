import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:my_app/components/my_button.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;
import 'package:my_app/pages/delivery_progress_page.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:web3dart/web3dart.dart';

enum PaymentMethod { CreditCard, SepoliaETH }

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  late W3MService _w3mService;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: PaymentMethod.values.length, vsync: this);
    _initializeService();
  }

  void _initializeService() async {
    W3MChainPresets.chains.putIfAbsent('11155111', () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: "6eb22eeeb3a8ba236cdb3a8b90727142",
      logLevel: LogLevel.error,
      metadata: const PairingMetadata(
        name: "W3M Flutter",
        description: "W3M Flutter test app",
        url: 'https://www.walletconnect.com/',
        icons: ['https://web3modal.com/images/rpc-illustration.png'],
        redirect: Redirect(
          native: 'my_app://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void userTapped() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder Name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryProgressPage(),
                  ),
                );
              },
              child: const Text("Yes"),
            )
          ],
        ),
      );
    }
  }

  Future<void> sendETH() async {
    final List<String> accounts =
        _w3mService.session?.getAccounts() ?? <String>[];
    if (accounts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please connect your wallet')),
      );
      return;
    }

    final String sender = accounts.first.split(':').last;
    const String recipient = '0xA7edb17005F0fD81b6E1d4321d8a053491D3a238';

    try {
      _w3mService.launchConnectedWallet();

      final factory = Provider.of<MyAppFactory.Factory>(context, listen: false);
      final totalETHInt = factory.getTotalPrice() / 111000;
      final totalETH = BigInt.from(totalETHInt * 1000000000000000000);

      await _w3mService.request(
        topic: _w3mService.session?.topic ?? '',
        chainId: 'eip155:$_chainId',
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            {
              'from': sender,
              'to': recipient,
              'value': '0x${totalETH.toRadixString(16)}',
            }
          ],
        ),
      );
   
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    
      await _w3mService.disconnect();
      await   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryProgressPage(),
                    ),
                  );
    
  }

  

  void userTappedETH() {
    final List<String> accounts =
        _w3mService.session?.getAccounts() ?? <String>[];
    if (accounts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please connect your wallet')),
      );
      return;
    }

    final String sender = accounts.first.split(':').last;

    showDialog(
      context: context,
      builder: (context) => Consumer<MyAppFactory.Factory>(
        builder: (context, factory, child) {
          final totalETHInt = factory.getTotalPrice() / 111000;
          final totalETH = BigInt.from(totalETHInt * 1000000000000000000);

          return AlertDialog(
            title: const Text("Confirm Payment"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Address: $sender"),
                  Text("Total amount in NTD: ${factory.getTotalPrice()}"),
                  Text("Equivalent amount in ETH: $totalETHInt"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  sendETH();
                },
                child: const Text("Yes"),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Checkout'),
        bottom: TabBar(
          controller: _tabController,
          tabs: PaymentMethod.values.map((PaymentMethod method) {
            return Tab(
                text: method == PaymentMethod.CreditCard
                    ? 'Credit Card'
                    : 'Sepolia ETH');
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: PaymentMethod.values.map((PaymentMethod method) {
          if (method == PaymentMethod.CreditCard) {
            return Column(
              children: [
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  onCreditCardWidgetChange: (p0) {},
                ),
                CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (data) {
                    setState(() {
                      cardNumber = data.cardNumber;
                      expiryDate = data.expiryDate;
                      cardHolderName = data.cardHolderName;
                      cvvCode = data.cvvCode;
                    });
                  },
                  formKey: formKey,
                ),
                const Spacer(),
                MyButton(
                  text: "Pay now",
                  onTap: userTapped,
                ),
                const SizedBox(height: 25),
              ],
            );
          } else if (method == PaymentMethod.SepoliaETH) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Please connect your wallet",
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 20),
                W3MNetworkSelectButton(service: _w3mService),
                SizedBox(height: 20),
                W3MConnectWalletButton(service: _w3mService),
                SizedBox(height: 20),
                W3MAccountButton(service: _w3mService),
                const Spacer(),
                MyButton(
                  text: "Pay now",
                  onTap: userTappedETH,
                ),
                const SizedBox(height: 25),
              ],
            );
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }
}

const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  namespace: 'eip155:$_chainId',
  chainId: _chainId,
  tokenName: 'ETH',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);


//Example of Token Transfer
//     const uniContractAddress = "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984";
//     const abi = [
//       {
//         "inputs": [
//           {"internalType": "address", "name": "account", "type": "address"}
//         ],
//         "name": "balanceOf",
//         "outputs": [
//           {"internalType": "uint256", "name": "", "type": "uint256"}
//         ],
//         "stateMutability": "view",
//         "type": "function"
//       },
//       {
//         "inputs": [],
//         "name": "decimals",
//         "outputs": [
//           {"internalType": "uint8", "name": "", "type": "uint8"}
//         ],
//         "stateMutability": "view",
//         "type": "function"
//       },
//       {
//         "inputs": [
//           {"internalType": "address", "name": "recipient", "type": "address"},
//           {"internalType": "uint256", "name": "amount", "type": "uint256"}
//         ],
//         "name": "transfer",
//         "outputs": [
//           {"internalType": "bool", "name": "", "type": "bool"}
//         ],
//         "stateMutability": "nonpayable",
//         "type": "function"
//       },
//     ];

//     final deployedContract = DeployedContract(
//       ContractAbi.fromJson(
//         jsonEncode(abi),
//         'ERC20',
//       ),
//       EthereumAddress.fromHex(uniContractAddress), // Contract address
//     );

      // final result = await _w3mService.requestWriteContract(
      //   topic: _w3mService.session?.topic ?? "",
      //   chainId: 'eip155:$_chainId',
      //   deployedContract: deployedContract,
      //   functionName: 'transfer',
      //   parameters: [
      //     EthereumAddress.fromHex(recipient),
      //     BigInt.from(10000000000000000) // 0.01 ETH in wei
      //   ],
      //   transaction: Transaction(
      //     from: EthereumAddress.fromHex(sender),
      //   ),
      // );

