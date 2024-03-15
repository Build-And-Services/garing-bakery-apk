import 'package:flutter/material.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text("Something went wrong!, check your connection"),
      ),
    );
  }
}
