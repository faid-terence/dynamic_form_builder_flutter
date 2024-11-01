import 'package:dynamic_form_generator/components/card_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            // Welcome text
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello , Faid',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What would you like to do\n today?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Alert card
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Your definitive driving test is on Tuesday,\nMay 04, below is your test code"),
                            Text(
                              "NYG12345678900987653467",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CardComponent(
                title: "Make Paytment",
                subtitle: "Traffic fines, community health based insurance",
                // use coins hand icon
                icon: FontAwesomeIcons.handHolding,
                color: Colors.blue,
                onTap: () {
                  Navigator.pushNamed(context, "/makePayments");
                },
              ),
              const SizedBox(height: 20),

              CardComponent(
                title: "My certificates",
                subtitle: "Birth certificate, celibacy certificate and more ",
                icon: FontAwesomeIcons.fileAlt,
                color: Color(0xFF8413F5),
                onTap: () {
                  Navigator.pushNamed(context, "/certificates");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
