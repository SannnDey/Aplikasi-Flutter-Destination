import 'package:flutter/material.dart';
import 'package:myapp/model/tourism_place.dart';

class DetailScreen extends StatefulWidget {
  final TourismPlace place;
  final String userEmail; // New property

  const DetailScreen({required this.place, required this.userEmail, super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        backgroundColor: Colors.orange[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.place.imageAsset,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  widget.place.imageAsset,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.red[700]),
                      const SizedBox(width: 5),
                      Text(
                        widget.place.location,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.place.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildInfoTable(),
                  const SizedBox(height: 20),
                  _buildRatingRow(),
                  const SizedBox(height: 20),
                  _buildCommentInput(),
                  const SizedBox(height: 20),
                  _buildCommentsHistory(),
                  const SizedBox(height: 20),
                  _buildReviewsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      children: [
        _buildTableRow('Open Days:', widget.place.openDays),
        _buildTableRow('Open Time:', widget.place.openTime),
        _buildTableRow('Ticket Price:', widget.place.ticketPrice),
      ],
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        const Text(
          'Rating: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (int i = 0; i < 5; i++)
          const Icon(Icons.star, color: Colors.yellow),
      ],
    );
  }

  Widget _buildCommentInput() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // Shadow position
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Review:',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _commentController,
          maxLines: 4, // Allow multiple lines for comments
          decoration: InputDecoration(
            labelText: 'Write your Review...',
            labelStyle: TextStyle(color: Colors.orange[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.orange[400]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.orange[800]!, width: 2.0),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _submitComment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[800],
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

  void _submitComment() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                'Submitting...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    setState(() {
      String submittedComment = _commentController.text;
      if (submittedComment.isNotEmpty) {
        // Combine email and comment
        String commentWithEmail = '${widget.userEmail}: $submittedComment';
        _comments.add(commentWithEmail); // Store comment with email
      }
    });

    Navigator.of(context).pop();
    _showCommentDialog(context, _commentController.text);
  });
}

  Widget _buildCommentsHistory() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.orange[50], // Light background for comments history
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // Shadow effect
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // Changes position of shadow
        ),
      ],
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Review History:',
          style: TextStyle(
            fontSize: 22.0, // Slightly larger font size
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        const SizedBox(height: 10),
        // Display comments in a vertical list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _comments.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              elevation: 5, // Increased elevation for a more prominent shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.comment, // Icon to represent a comment
                      color: Colors.orange[800],
                      size: 24,
                    ),
                    const SizedBox(width: 10), // Spacing between icon and text
                    Expanded( // Use Expanded to make the text flexible
                      child: Text(
                        _comments[index],
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}


  Widget _buildReviewsSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.orange[50], // Light background for reviews section
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // Shadow effect
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // Changes position of shadow
        ),
      ],
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews History:',
          style: TextStyle(
            fontSize: 22.0, // Slightly larger font size for the title
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        const SizedBox(height: 10),
        // Display reviews in a vertical list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.place.reviews.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              elevation: 5, // Increased elevation for a more prominent shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star, // Icon to represent a review
                      color: Colors.orange[800],
                      size: 24,
                    ),
                    const SizedBox(width: 10), // Spacing between icon and text
                    Expanded( // Use Expanded to make the text flexible
                      child: Text(
                        widget.place.reviews[index],
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}


  void _showCommentDialog(BuildContext context, String comment) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Use a StatefulBuilder to manage the state of the dialog
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          // Create a variable to control the visibility of the dialog
          bool isDialogVisible = true;

          // Automatically dismiss the dialog after a certain duration
          Future.delayed(const Duration(seconds: 2), () {
            if (isDialogVisible) {
              Navigator.of(context).pop(); // Dismiss the dialog
            }
          });

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.orange[50],
            title: const Text(
              'Comment Submitted!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your comment has been submitted:\n\n$comment',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
              ],
            ),
            // Remove the actions since we don't need a button to dismiss
          );
        },
      );
    },
  );
}

}
