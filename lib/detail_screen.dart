import 'package:flutter/material.dart';
import 'package:myapp/model/tourism_place.dart';

class DetailScreen extends StatefulWidget {
  final TourismPlace place;

  const DetailScreen({required this.place, super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];
  String? _submittedComment;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Review:',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            labelText: 'Write your Review...',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange[800]!, width: 2.0),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submitComment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[800],
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void _submitComment() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Submitting...'),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _submittedComment = _commentController.text;
        if (_submittedComment != null && _submittedComment!.isNotEmpty) {
          _comments.add(_submittedComment!);
        }
      });

      Navigator.of(context).pop();
      showCommentDialog(context, _submittedComment!);
    });
  }

  Widget _buildCommentsHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Review History:',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _comments.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _comments[index],
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews History:',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.place.reviews.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.reviews[index],
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void showCommentDialog(BuildContext context, String comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          backgroundColor: Colors.orange[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green[600], size: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Comment Submitted!\nYour comment: $comment',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
