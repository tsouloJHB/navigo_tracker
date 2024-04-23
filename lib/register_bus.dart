import 'package:flutter/material.dart';
import 'package:navigo_tracker/bus_info_state.dart';
import 'package:navigo_tracker/models/BusInfo.dart';
import 'package:navigo_tracker/services/bus_communication_services.dart';
import 'package:navigo_tracker/homePage.dart';
import 'package:provider/provider.dart';

class RegisterBus extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController busNumberController = TextEditingController();
  final TextEditingController busIdController = TextEditingController();

  RegisterBus({super.key});

  void _sendBusInfo(BuildContext context) async {
    final busInfo = BusInfo(
      name: nameController.text,
      busNumber: busNumberController.text,
      busId: busIdController.text,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text("Sending bus info..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      await BusCommunicationServices.sendBusInfo(busInfo);

      final busInfoUpdate = Provider.of<BusInfoState>(context, listen: false);
      busInfoUpdate.setBusInfo(busInfo);
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss the dialog
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    } catch (error) {
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to send bus info. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    busIdController.text = "1234";
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80.0),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.7, // Adjust the height as needed
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bus Registration',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Good day bus driver, insert info below',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name & Surname',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextField(
                        controller: busNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Bus Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextField(
                        controller: busIdController,
                        decoration: const InputDecoration(
                          labelText: 'Bus ID',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      2 /
                      3, // Making the button width two-thirds of the screen width
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _sendBusInfo(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                    child: const Text('Start'),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
