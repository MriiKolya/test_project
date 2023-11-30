import 'package:flutter/material.dart';
import 'package:testproject/core/widgets/wraper_textfield.dart';
import 'package:testproject/features/constant/constants.dart';
import 'package:testproject/features/models/submit_model.dart';

class AddHouseAlert extends StatelessWidget {
  AddHouseAlert({super.key, required this.onSubmit});

  final formKey = GlobalKey<FormState>();
  final textEditingControllerName = TextEditingController();
  final textEditingControllerFloor = TextEditingController();
  final ValueChanged<SubmitHouse> onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Spacer(),
          Text(
            'Add house',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 30),
          )
        ],
      ),
      content: Form(
        key: formKey,
        child: SizedBox(
          height: 120,
          width: 320,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Floors count',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WraperTextFormField(
                    textEditingController: textEditingControllerName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  WraperTextFormField(
                    textEditingController: textEditingControllerFloor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a floors count';
                      } else {
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Enter only digits';
                        } else if (int.tryParse(value)! < 1 ||
                            int.tryParse(value)! > 8) {
                          return 'Choose a floor: 1-8';
                        } else {
                          return null;
                        }
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
            style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(100, 25),
                ),
                backgroundColor: MaterialStatePropertyAll(backgroundTextField)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmit(SubmitHouse(
                  name: textEditingControllerName.text.trim(),
                  floor: int.tryParse(textEditingControllerFloor.text.trim())!,
                ));
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 17),
            ),
          ),
        )
      ],
    );
  }
}
