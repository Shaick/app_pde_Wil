import 'package:flutter/material.dart';

import 'custom_load_button.dart';
import 'custom_rating_bar.dart';

class CustomRatingDialog extends StatefulWidget {
  /// Disables the cancel button and forces the user to leave a rating
  final bool force;

  /// The initial rating of the rating bar
  final int initialRating;

  /// Returns a RatingDialogResponse with user's rating and comment values
  final Function(RatingDialogResponse) onSubmitted;

  const CustomRatingDialog(
      {Key? key,
      this.force = false,
      this.initialRating = 1,
      required this.onSubmitted})
      : super(key: key);

  @override
  _CustomRatingDialogState createState() => _CustomRatingDialogState();
}

class _CustomRatingDialogState extends State<CustomRatingDialog> {
  @override
  Widget build(BuildContext context) {
    final _commentController = TextEditingController();
    final _response = RatingDialogResponse(rating: widget.initialRating);

    final _content = Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Avalie seu professor',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Center(
                  child: RatingBar.builder(
                    initialRating: widget.initialRating.toDouble(),
                    glowColor: Colors.amber,
                    minRating: 1.0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (rating) =>
                        _response.rating = rating.toInt(),
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomLoadButton(
                      title: 'Enviar',
                      loading: false,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green.shade400)),
                      onPressed: () {
                        if (!widget.force) Navigator.pop(context);
                        _response.comment = _commentController.text;
                        widget.onSubmitted.call(_response);
                      }),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        if (!widget.force) ...[
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () {
              Navigator.pop(context);

            },
          )
        ]
      ],
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      title: _content,
    );
  }
}

class RatingDialogResponse {
  /// The user's comment response
  String comment = '';

  /// The user's rating response
  int rating;

  RatingDialogResponse({this.rating = 1});
}
