import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
class GlobalLikeButton extends StatefulWidget {
  const GlobalLikeButton({Key? key}) : super(key: key);

  @override
  State<GlobalLikeButton> createState() => _GlobalLikeButtonState();
}

class _GlobalLikeButtonState extends State<GlobalLikeButton> {
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 30,
      circleColor: const CircleColor(
          start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
          size: 30,
        );
      },
      onTap: (selected) async {
        Fluttertoast.showToast(
          msg: "Favoritlarga qo'shildi",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP_LEFT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        setState(() {
          selected != selected;
        });
        selected ? true : false;
        return !selected;
      },
    );
  }
}
