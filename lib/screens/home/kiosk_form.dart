import 'package:flutter/material.dart';

class KioskForm extends StatefulWidget {
  const KioskForm({Key? key}) : super(key: key);

  @override
  _KioskFormState createState() => _KioskFormState();
}

class _KioskFormState extends State<KioskForm> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Shop name',
              hintText: 'Enter the shop name',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Owner's name",
              hintText: "Enter the owner's name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Owner's mobile",
              hintText: "Enter the owner's mobile number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("What is the kiosk's nature?"),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('FMCG goods'),
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Food Kibandaski'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Gas outlet'),
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Mama Mboga'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Wines and spirits shop'),
            ],
          ),
          const Text('How do you pay your suppliers?'),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Cash'),
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Mpesa'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Bank deposit'),
            ],
          ),
          const Text('Do you accept Mpesa payments'),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Yes'),
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('No'),
            ],
          ),
          const Text("Kiosk owner's gender"),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Male'),
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('Female'),
            ],
          ),
        ],
      ),
    );
  }
}
