import 'package:flutter/material.dart';

class HeaderBar extends StatefulWidget {
  HeaderBar({super.key, required this.OnDateChanged});

  late Function OnDateChanged;

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              widget.OnDateChanged(await showDatePicker(
                  context: context,
                  locale: const Locale("it", "IT"),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2050),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.dark(),
                      child: child!,
                    );
                  }));
            },
            icon: const Icon(Icons.menu, color: Colors.deepPurpleAccent),
          ),
          const Text(
            "UniLessons",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ],
      ),
    );
  }
}
