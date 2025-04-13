import 'package:flutter/material.dart';

class Dialogue extends StatelessWidget {
  final VoidCallback onConfirm;
  final String message;

  const Dialogue({
    Key? key,
    required this.onConfirm,
    required this.message ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.99,
        height: MediaQuery.of(context).size.height * 0.99,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.grey, width: 5),
          ),
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Literata',
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            SizedBox(
              width: 110,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFBBC05),
                  foregroundColor: const Color(0xffB6B6B6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Literata',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: TextButton(
                onPressed: () {
                  onConfirm();
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: 'Literata',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
